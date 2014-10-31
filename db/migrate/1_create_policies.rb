Sequel.migration do
  change do
    create_table(:policies) do
      primary_key :id
      String :bucket_url, :null=>false
      String :origin, :null=>false
      String :access_key_id, :null=>false
      String :secret_access_key, :null=>false
      String :endpoint_hash, :null=>false
    end
  end
end
