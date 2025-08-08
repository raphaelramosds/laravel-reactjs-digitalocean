# Arte Marca

## Developer enviroment

```bash
bash setup
```

## Deploy

Although this repository is configured to trigger a GitHub Actions workflow that deploys the application as an App Platform instance on DigitalOcean with every push to the main branch, a local CI environment has been set up using [Act](https://nektosact.com/) for testing purposes.

Therefore, to perform this deployment, please follow the steps below:

```bash
# Set actions secrets and variables
cp .act.secrets.example .act.secrets && \
cp .act.variables.example .act.variables

# Run the CI Pipeline
act --secret-file .act.secrets --var-file .act.variables
```

> ⚠️ Even if you choose to run the pipeline locally with Act, you must still set the secrets and variables in this repository on GitHub to ensure the pipeline runs smoothly on the GitHub Actions runner whenever the main branch receives a push!