# frozen_string_literal: true

require 'rails_helper' # not 'rspec', becuase in Rails spec files, it is recommended to require 'rails_helper', not 'spec_helper' or 'rspec'. The 'rails_helper' file includes the 'spec_helper' file and also sets up the Rails environment, which is necessary for running tests that interact with the Rails framework

RSpec.describe ReturnDeviceFromUser do
  subject(:return_device) do
    described_class.new(
      requesting_user: requesting_user,
      serial_number: serial_number,
      from_user: from_user_id
    ).call
  end

  let(:requesting_user) { create(:user) }
  let(:serial_number) { '987654' }
end
