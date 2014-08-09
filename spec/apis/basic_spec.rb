require 'spec_helper'

describe PicPicAPI do

  describe "Basic response" do

    def app
      PicPicAPI
    end

    context 'when logged in' do
      before { get "/api/v1" }
      it { expect(last_response).to be_ok }
    end
  end
end