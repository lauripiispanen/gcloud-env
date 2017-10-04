GCE Environment config
======================

For fresh setup, you'll need to grab credentials and `account.json` from Google Cloud Console.

### Configuration

Set appropriate Terraform variables (project, ssh_inbound_ip). You can source them from a `.env` file.

Configure GCE dynamic inventory for Ansible: download and setup `gce.ini` from [Ansible contrib](https://github.com/ansible/ansible/tree/devel/contrib/inventory). Add credentials for `gce.py` to use your service account.

**Example:**

```
gce_service_account_email_address = 1234567890-compute@developer.gserviceaccount.com
gce_service_account_pem_file_path = account.json
gce_project_id = project-12345678
```

Then setup a new Python virtualenv and activate it, then install dependencies.

```
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

Make sure to have your SSH key registered with ssh-agent.

```
ssh-agent
ssh-add <path to private key>
```



### Running

`terraform plan -var [project]` and `terraform apply`. `terraform destroy` to pull instances down.
