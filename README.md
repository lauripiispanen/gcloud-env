GCE Environment config
======================

For fresh setup, you'll need to grab credentials and `account.json` from Google Cloud Console.

### Configuration

Configure GCE dynamic inventory for Ansible: download and setup `gce.ini` from [Ansible contrib](https://github.com/ansible/ansible/tree/devel/contrib/inventory). Add credentials for `gce.py` to use your service account.

**Example:**

```
gce_service_account_email_address = 1234567890-compute@developer.gserviceaccount.com
gce_service_account_pem_file_path = account.json
gce_project_id = project-12345678
```

### Running

`terraform plan -var [project]` and `terraform apply`. `terraform destroy` to pull instances down.
