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

  path '/unassign' do
    post 'Unassign a device from current user' do
      tags 'Devices'
      consumes 'application/json'
      parameter name: :unassign_request, in: :body, schema: {
        type: :object,
        properties: {
          device: {
            type: :object,
            properties: {
              serial_number: { type: :string }
            },
            required: ['serial_number']
          }
        },
        required: ['device']
      }

      response '200', 'device unassigned' do
        let(:unassign_request) { { device: { serial_number: '123456' } } }
        run_test!
      end
    end
  end

  path '/assigned' do
    get 'List all devices assigned to current user' do
      tags 'Devices'
      produces 'application/json'

      response '200', 'list of assigned devices' do
        run_test!
      end
    end
  end

  path '/device_history/{serial_number}' do
    get 'Get ownership history for a device' do
      tags 'Devices'
      produces 'application/json'
      parameter name: :serial_number, in: :path, type: :string

      response '200', 'ownership history returned' do
        let(:serial_number) { '123456' }
        run_test!
      end

      response '404', 'device not found' do
        let(:serial_number) { 'nonexistent' }
        run_test!
      end
    end
  end
end
