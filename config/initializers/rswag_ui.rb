Rswag::Ui.configure do |c|

  # List the Swagger endpoints that you want to be documented through the
  # swagger-ui. The first parameter is the path (absolute or relative to the UI
  # host) to the corresponding endpoint and the second is a title that will be
  # displayed in the document selector.
  # NOTE: If you're using rspec-api to expose Swagger files
  # (under openapi_root) as JSON or YAML endpoints, then the list below should
  # correspond to the relative paths for those endpoints.

  c.swagger_endpoint '/api-docs/v1/swagger.yaml', 'API V1 Docs'

  # Set defoult hosta to localhost:3000 (HTTP, no HTTPS)
  c.config_object[:urls] = [
    {
      url: '/api-docs/v1/swagger.yaml',
      name: 'API V1 Docs',
      variables: {
        defaultHost: {
          default: 'localhost:3000'
        }
      }
    }
  ]
end
