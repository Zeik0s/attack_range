# Attack Range Config

## attack_range.yml
attack_range.yml is the configuration file for Attack Range. Attack Range reads first the default configuration file located in configs/attack_range_default.yml and then the attack_range.yml (or the config which you specify with the -c parameter). The parameters in attack_range.yml override the parameters in configs/attack_range_default.yml. 

## attack_range_default.yml
The attack_range_default.yml defines all default values for the Attack Range. The following file contains some comments to describe the different parameters:
````
general:
  attack_range_password: "Pl3ase-k1Ll-me:p"
# Attack Range Master Password for all accounts in Attack Range.

  cloud_provider: "aws"
# Cloud Provider: aws/azure/local

  key_name: "attack-range-key-pair"
# The key name is the name of the AWS key pair and in the same time an unique identitfier for Attack Ranges

  attack_range_name: "ar"
# Attack range Name let you build multiple Attack Ranges by changing this parameter.

  ip_whitelist: "0.0.0.0/0"
# Blocks from which Attack Range machines can be reached.
# This allow comma-separated blocks
# ip_whitelist = 0.0.0.0/0,35.153.82.195/32

  version: "3.0.0"
# The current released version of Attack Range

  crowdstrike_falcon: "0"
# Enable/Disable Crowdstrike Falcon by setting it to 1 or 0

  crowdstrike_agent_name: "WindowsSensor.exe"
  crowdstrike_customer_ID: ""
  crowdstrike_logs_region: ""
  crowdstrike_logs_access_key_id: ""
  crowdstrike_logs_secret_access_key: ""
  crowdstrike_logs_sqs_url: ""
# All these fields all needed to automatically deploy a Crowdstrike Agent and ingest Crowdstrike Falcon logs into the Splunk Server. See the chapter Crowdstrike Falcon in the docs page Attack Range Features.

  carbon_black_cloud: "0"
# Enable/Disable VMWare Carbon Black Cloud by setting it to 1 or 0

  carbon_black_cloud_agent_name: "installer_vista_win7_win8-64-3.8.0.627.msi"
  carbon_black_cloud_company_code: ""
  carbon_black_cloud_s3_bucket: ""
# All these fields all needed to automatically deploy a Carbon Black Agent and ingest Carbon Black logs into the Splunk Server. See the chapter Carbon Black in the docs page Attack Range Features.

aws:
  region: "eu-central-1"
# region used in AWS. This should be the same as the region configured in AWS cli.

  private_key_path: "~/.ssh/id_rsa"
# path to your private key. This need to match the public key uplaoded to AWS.  

  cloudtrail: "0"
# Enable/Disable Cloudtrail with 1/0

  cloudtrail_sqs_queue: "https://sqs.us-west-2.amazonaws.com/111111111111/cloudtrail-cloud-attack-range"
# Cloudtrail SQS queue. See the chapter AWS Cloudtrail in the docs page Attack Range Cloud.

azure:
  region: "West Europe"
# region used in Azure. 

  subscription_id: "xxx"
# Azure subscription id

  private_key_path: "~/.ssh/id_rsa"
# path to your private key.

  public_key_path: "~/.ssh/id_rsa.pub"
# path to your public key.

  azure_logging: "0"
# Enable/Disable Azure logs and onboard them into the Splunk Server with 1/0.

  app_id: "xxx"
  client_secret: "xxx"
  tenant_id: "xxx"
  event_hub_name: "xxx"
  event_hub_host_name: "xxx"
# This fields are needed to configure the Azure logs. More information can be found in the chapter Azure Logs in Attack Range Cloud.

local:
  provider: "Virtual Box"
# Attack Range Local used Virtualbox and Vagrant to build the Attack Range.

splunk_server:
  image: "splunk-v3-0-0"
# name of the image of the Splunk Server. Packer is used to build this images.

  install_es: "0"
# Enable/Disbale Enterprise Security

  splunk_es_app: "splunk-enterprise-security_701.spl"
# File name of the Enterprise Security spl file. Need to be located in the apps folder.


phantom_server:
  phantom_server: "0"
# Enable/Disable Phantom Server

  phantom_community_username: user
# Specify the username needed to login to my.phantom.us to download Phantom
# This must be changed to a real username
# You can register under my.phantom.us

  phantom_community_password: password
# Specify the password used to login to my.phantom.us to download Phantom
# This must be changed to a real password
# You can register under my.phantom.us

  phantom_repo_url: https://repo.phantom.us/phantom/5.2/base/7/x86_64/phantom_repo-5.2.1.78411-1.x86_64.rpm
# Specify the Phantom install RPM

  phantom_version: "5.2.1.78411-1"
# Fields the Phantom Version

windows_servers_default:
  hostname: ar-win 
# Define the hostname for the Windows Server

  image: windows-2016-v3-0-0
# name of the image of the Windows Server. Packer is used to build this images.

  create_domain: "0"
# Create Domain will turn this Windows Server into a Domain Controller

  join_domain: "0"
# Join a domain

  win_sysmon_config: "SwiftOnSecurity.xml"
# Specify a sysmon config located under configs/ .

  install_red_team_tools: "0"
# Install different read team tools

  bad_blood: "0"
# Install Bad Blood. More inforamtion in chapter Bad Blood under Attack Range Features.

linux_servers_default:
  hostname: ar-linux
# Define the hostname for the Linux Server

  image: linux-v3-0-0
# name of the image of the Linux Server. Packer is used to build this images.

  sysmon_config: "SysMonLinux-CatchAll.xml"
# Specify a sysmon config located under configs/ .

kali_server:
  kali_server: "0"
# Enable Kali Server

nginx_server:
  nginx_server: "0"
# Enable Nginx Server

  image: nginx-web-proxy-v3-0-0
# Specify the image used for Nginx Server

  proxy_server_ip: "10.0.1.12"
# Specify what ip to proxy

  proxy_server_port: "8000"
# Specify what port to proxy

zeek_server:
  zeek_server: "0"
# Enable Zeek Server

  image: "zeek-v3-0-0"
# Specify the image used for Zeek Server

simulation:
  atomic_red_team_repo: redcanaryco
# Specify the repostory owner for Atomic Red Team

  atomic_red_team_branch: master
# Specify the branch for Atomic Red Team

  prelude: "0"
# Install Prelude

  prelude_operator_url: "https://download.prelude.org/latest?arch=x64&platform=linux&variant=zip&edition=headless"
# Specify where to download Prelude Operator from

  prelude_account_email: "test@test.com"
# Email account login into a Prelude Operator UI
# required for connecting to redirector, can be found on the GUI under connect>deploy manual redirector> accountEmail.

````

