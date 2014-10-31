Policy Uploader
---------------

A sinatra S3 policy generator, and an accompanying jQuery plugin to use on
your website.

```
POST /policy
  IN
    - bucket_url: String
    - origin: String
    - access_key_id: String
    - secret_access_key: String
  OUT
    - endpoint_url: String

GET /policy/#{uniqueid}

  - policy: String
  - signature: String
  - acl: String
  - uuid: String
  - bucket_url: String

```
