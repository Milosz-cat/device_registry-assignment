require 'swagger_helper'

RSpec.describe 'Devices API', type: :request do
  path '/assign' do
    post 'Assign a device to user' do
      tags 'Devices'
      consumes 'application/json'
      parameter name: :assign_request, in: :body, schema: {
        type: :object,
        properties: {
          new_owner_id: { type: :integer },
          device: {
            type: :object,
            properties: {
              serial_number: { type: :string }
            },
            required: ['serial_number']
          }
        },
        required: ['new_owner_id', 'device']
      }

      response '200', 'device assigned' do
        let(:assign_request) { { new_owner_id: 1, device: { serial_number: '123456' } } }
        run_test!
      end

      response '422', 'unauthorized' do
        let(:assign_request) { { new_owner_id: nil, device: { serial_number: '' } } }
        run_test!
      end
    end
  end
end
