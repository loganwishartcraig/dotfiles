return {
  settings = {
    json = {
      -- Find more schemas here: https://www.schemastore.org/json/
      schemas = {
        {
          description = "TypeScript compiler configuration file",
          fileMatch = {
            "tsconfig.json",
            "tsconfig.*.json",
          },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          description = "ESLint config",
          fileMatch = {
            ".eslintrc.json",
            ".eslintrc",
          },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          description = "NPM configuration file",
          fileMatch = {
            "package.json",
          },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "JSON schema for Visual Studio component configuration files",
          fileMatch = {
            "*.vsconfig",
          },
          url = "https://json.schemastore.org/vsconfig.json",
        },
      },
    },
  }
}

return opts
