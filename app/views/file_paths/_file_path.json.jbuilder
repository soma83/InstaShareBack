json.extract! file_path, :id, :name, :path, :created_at, :updated_at
json.url file_path_url(file_path, format: :json)
