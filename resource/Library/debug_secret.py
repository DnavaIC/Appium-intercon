import boto3
import json

def debug_aws_secret(secret_name, region_name="us-east-1"):
    print(f"Attempting to connect to AWS Secrets Manager in {region_name}...")
    
    try:
        session = boto3.session.Session()
        client = session.client(
            service_name='secretsmanager',
            region_name=region_name
        )

        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )

        if 'SecretString' in get_secret_value_response:
            secret_str = get_secret_value_response['SecretString']
            secret_json = json.loads(secret_str)
            
            print("\n SUCCESS! Secret found.")
            print("-" * 30)
            print(json.dumps(secret_json, indent=4))
            print("-" * 30)
            
        else:
            print("The secret exists but is not a String (it might be binary).")

    except Exception as e:
        print(f"\n ERROR: Could not retrieve the secret.")
        print(f"Details: {e}")
        print("\nSuggestion: Verify that your AWS credentials are configured in this terminal.")

if __name__ == "__main__":
    SECRET_NAME = "offboarding_active_directory"
    debug_aws_secret(SECRET_NAME)