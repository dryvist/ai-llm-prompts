{
  description = "Versioned Dryvist LLM prompt catalog";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      catalogDirectories = [
        ./auto-ai-agent
        ./automation
        ./applications
        ./developer-tools
      ];
      promptFiles = nixpkgs.lib.concatMap
        (directory:
          let entries = builtins.readDir directory;
          in map
            (name: directory + "/${name}")
            (builtins.filter
              (name: entries.${name} == "regular" && nixpkgs.lib.hasSuffix ".md" name && name != "index.md")
              (builtins.attrNames entries)))
        catalogDirectories;
      requiredFields = [
        "type"
        "title"
        "description"
        "resource"
        "tags"
        "timestamp"
        "status"
        "consumers"
        "render"
        "source_history"
      ];
      fieldValue = field: path:
        let
          prefix = "${field}:";
          lines = nixpkgs.lib.splitString "\n" (builtins.readFile path);
          matches = builtins.filter (line: nixpkgs.lib.hasPrefix prefix line) lines;
        in
        if matches == [ ] then null else nixpkgs.lib.removePrefix prefix (builtins.head matches);
      validPrompt = path:
        let promptType = nixpkgs.lib.trim (fieldValue "type" path);
        in
        nixpkgs.lib.all (field: fieldValue field path != null) requiredFields
        && builtins.elem promptType [ "LLM Prompt" "LLM Prompt Fragment" ];
      resources = map (path: nixpkgs.lib.trim (fieldValue "resource" path)) promptFiles;
      promptBody = path:
        nixpkgs.lib.concatStringsSep "\n---\n"
          (nixpkgs.lib.drop 1 (nixpkgs.lib.splitString "\n---\n" (builtins.readFile path)));
      bodyHashes = map (path: builtins.hashString "sha256" (promptBody path)) promptFiles;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          mkCatalog = name: path: pkgs.linkFarm "ai-llm-prompts-${name}" [
            {
              name = "share/ai-llm-prompts/${name}";
              inherit path;
            }
          ];
          auto-ai-agent = mkCatalog "auto-ai-agent" ./auto-ai-agent;
          automation = mkCatalog "automation" ./automation;
          applications = mkCatalog "applications" ./applications;
          developer-tools = mkCatalog "developer-tools" ./developer-tools;
        in
        {
          inherit auto-ai-agent automation applications developer-tools;
          default = pkgs.symlinkJoin {
            name = "ai-llm-prompts";
            paths = [ auto-ai-agent automation applications developer-tools ];
          };
        });

      checks = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in
        self.packages.${system} // {
          okf = assert nixpkgs.lib.all validPrompt promptFiles;
            assert builtins.length resources == builtins.length (nixpkgs.lib.unique resources);
            assert builtins.length bodyHashes == builtins.length (nixpkgs.lib.unique bodyHashes);
            pkgs.writeText "ai-llm-prompts-okf-validation" "Validated ${toString (builtins.length promptFiles)} unique OKF prompts.\n";
        });

      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              markdownlint-cli2
              pre-commit
              yq-go
            ];
          };
        });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
