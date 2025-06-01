# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  let(:api_key) { create(:api_key) }
  let(:user) { api_key.bearer }


  describe 'POST #assign' do
    subject(:assign) do
      post :assign,
           params: { new_owner_id: new_owner_id, device: { serial_number: '123456' } },
           session: { token: user.api_keys.first.token }
    end
    context 'when the user is authenticated' do
      context 'when user assigns a device to another user' do
        let(:new_owner_id) { create(:user).id }

        it 'returns an unauthorized response' do
          assign # Without this the response would be empty, and by plain logic if context is "when user assigns a device..." we need to call the action
          expect(response.code).to eq("422") # test returns response.code as a string, so the test compares "422", not 422 (Integer)
          expect(JSON.parse(response.body)).to eq({ 'error' => 'Unauthorized' })
        end
      end

      context 'when user assigns a device to self' do
        let(:new_owner_id) { user.id }

        it 'returns a success response' do
          assign
          expect(response).to be_successful
        end
      end
    end

    context 'when the user is not authenticated' do
      it 'returns an unauthorized response' do
        post :assign
        expect(response).to be_unauthorized
      end
    end
  end

  describe 'POST #unassign' do
    let(:serial_number) { '123456' } # Use a shared serial number for consistency in tests
    let!(:device) { create(:device, serial_number: serial_number, owner: user) } # Create a device assigned to the user — required for the unassign logic to work

    subject(:unassign) do
      post :unassign,
          params: { device: { serial_number: serial_number } },
          session: { token: user.api_keys.first.token }
    end

    context 'when the user is authenticated' do # test are based on POST #assign test above
      context 'when user unassigns their own device' do
        before do
          create(:device_ownership, device: device, user: user, assigned_at: 1.day.ago) # Create a device_ownership record — this is required by the ReturnDeviceFromUser service
        end

        it 'returns a success response' do
          unassign
          expect(response).to be_successful
        end
      end

      context 'when user tries to unassign a device without ownership' do
        it 'returns an error response' do
          unassign
          expect(response.code).to eq("422")
          expect(JSON.parse(response.body)).to eq({ 'error' => 'Could not unassign device' })
        end
      end
    end

    context 'when the user is not authenticated' do
      it 'returns an unauthorized response' do
        post :unassign, params: { device: { serial_number: serial_number } }
        expect(response).to be_unauthorized
      end
    end
  end

  describe 'GET #assigned' do
    subject(:get_assigned) do
      get :assigned, session: { token: user.api_keys.first.token }
    end

    let!(:device1) { create(:device, serial_number: 'abc123', owner: user) }
    let!(:device2) { create(:device, serial_number: 'def456', owner: user) }
    let!(:device3) { create(:device, serial_number: 'ghi789', owner: create(:user)) }

    context 'when the user is authenticated' do
      it 'returns a list of devices assigned to the current user' do
        get_assigned
        expect(response).to be_successful

        json = JSON.parse(response.body)
        serials = json.map { |d| d['serial_number'] }

        expect(serials).to contain_exactly('abc123', 'def456')
        expect(serials).not_to include('ghi789')
      end
    end


  end

end
