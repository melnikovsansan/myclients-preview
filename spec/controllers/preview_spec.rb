require 'rails_helper'

RSpec.describe PreviewController, type: :controller do
  describe "POST /" do
    context 'Upload#attachment' do
      let(:params) do
        "e3a45fbb-ee31-457b-ac5b-d6959adf5671.docx"
        {
          model_name: 'Upload',
          attribute_name: 'attachment',
          bucket: "6a14df9e-0289-4df3-9ce0-e0474600534a",
          id: "80f5a6f5-8c04-45be-b9da-a44f64eae6fe",
          file_name: "e3a45fbb-ee31-457b-ac5b-d6959adf5671.docx",
          callback_url: nil,
        }
      end

      it 'create preview' do
        post :create, params: params

        expect(response).to be_successful
      end
    end
  end
end

=begin
/usr/lib/libreoffice/program/soffice.bin --headless --invisible --nocrashreport --nodefault --nologo --nofirststartwizard --norestore -env:UserInstallation=file:///tmp/tmp8ip81ibp --accept="socket,host=127.0.0.1,port=2002,tcpNoDelay=1;urp;StarOffice.ComponentContext"
=end
