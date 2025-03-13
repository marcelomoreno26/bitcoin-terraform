# GCP Infrastructure with Terraform

## Task
Use Terraform to create a new Google Cloud project, set up BigQuery datasets for staging and data mart tables, and provision a service account with the necessary BigQuery permissions. All resources should be managed through Terraform, with no manual creation of any additional resources.

## Repository Structure

```
├── main.tf
└── variables.tf
```

## Files Purpose
The `main.tf` file performs the following tasks:

1. **Set Google as the Provider**
   - Defines `hashicorp/google` as the required provider.

2. **Create a Google Cloud Project**
   - Uses `google_project` to create a new Google Cloud project.
   - Ensures the project is associated with a billing account, which is necessary to add tables to the datasets.

3. **Enable Required APIs**
   - Enables `cloudbilling.googleapis.com` and `bigquery.googleapis.com`, for billing and BigQuery operations.

4. **Create a Service Account and Assign Permissions**
   - Creates a service account.
   - Grants the service account the following roles:
     - `roles/billing.user` this permission is required to associate newly created resources (such as BigQuery tables) with the project's billing account.
     - `roles/bigquery.jobUser` to run queries.
     - `roles/bigquery.dataEditor` to create/modify datasets and tables.

5. **Create BigQuery Datasets**
   - Creates a `staging` dataset for intermediate data storage.
   - Creates a `data_marts` dataset for processed and analytical data.


The `variables.tf` file is used to make the Terraform templates reusable and improve readability by allowing configurations to be easily adjusted without modifying the main script. Below are the defined variables:

- **`project_id`**: The ID of the Google Cloud Project.  
- **`location`**: The location for BigQuery datasets.  
  - In this case, **US** is chosen because the dataset from which the staging will be created `bigquery-public-data.crypto_bitcoin` is also located in the US. Keeping everything in the same region ensures ease of access when using **dbt** to create the tables.  
- **`service_account`**: The ID for the service account that will be created.  
- **`billing_account`**: The ID for the billing account.  
  - This is the **only variable that needs to be manually updated** for the current purposes. The default value is currently set to `"<BILLING_ID>"`, and you can find your billing account ID by following [this guide](https://cloud.google.com/billing/docs/how-to/find-billing-account-id).  
- **`staging_id`**: The ID for the **staging** dataset in BigQuery.  
- **`data_marts_id`**: The ID for the **data_marts** dataset in BigQuery.  



## Creating the cloud Infrastructure
### Prerequisites
- A Google Cloud Platform account (with owner and create services account permissions) and a billing account.

- The [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed locally.

- [Terraform 1.2.0+](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli) installed locally.

- [Authenticate to google cloud](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#authenticate-to-google-cloud) from teminal. This is necessary as Terraform must authenticate to Google Cloud to create infrastructure.


### Creating Infrastructure
[Setup Tutorial Video](https://www.loom.com/share/723342eb3cb442b998d9095a2c0be103?sid=0c971c9e-c072-43b1-9c17-eba3cd6de12f)

1. Replace the `billing_account` id in  `variables.tf` to your own. 

2. Initialize Terraform. This command downloads the required provider plugins, initializes the backend, and sets up the `.terraform` directory.
   ```sh
   terraform init
   ```
3. Plan the infrastructure deployment:
   ```sh
   terraform plan
   ```
4. Apply the configuration. After running this command the project, and datasets should be visible in the google cloud platform. This also creates a `terraform.tfstate` file, which tracks the infrastructure state to manage and apply changes effectively:
   ```sh
   terraform apply
   ```
5. To destroy the infrastructure when no longer needed:
   ```sh
   terraform destroy
   ```




