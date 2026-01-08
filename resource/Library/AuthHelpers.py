import boto3
import json
import msal

class AuthHelpers:
    
    ROBOT_LIBRARY_SCOPE = 'SUITE'

    def get_aws_secret(self, secret_name, region_name="us-east-1"):
        session = boto3.session.Session()
        client = session.client(service_name='secretsmanager', region_name=region_name)
        
        try:
            get_secret_value_response = client.get_secret_value(SecretId=secret_name)
        except Exception as e:
            raise Exception(f"Error AWS: {e}")

        if 'SecretString' in get_secret_value_response:
            return json.loads(get_secret_value_response['SecretString'])
        else:
            raise Exception("This is not a valid secret string")

    def get_microsoft_access_token(self, tenant_id, client_id, client_secret):
        authority_url = f"https://login.microsoftonline.com/{tenant_id}"
        scope = ["https://graph.microsoft.com/.default"]
        
        app = msal.ConfidentialClientApplication(
            client_id,
            authority=authority_url,
            client_credential=client_secret,
        )
        
        result = app.acquire_token_for_client(scopes=scope)

        if "access_token" in result:
            return result["access_token"]
        else:
            err = result.get("error_description", result.get("error"))
            raise Exception(f"Error Microsoft Auth: {err}")