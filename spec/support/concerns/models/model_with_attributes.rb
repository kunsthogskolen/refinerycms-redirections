shared_examples_for "model with attributes" do |model_name|
  context "validations" do
    context "with valid values" do
      let(:attributes) { attributes_for model_name }
      let(:model_object) { build model_name, attributes }

      subject { model_object }

      it 'is valid' do
        expect(subject).to be_valid
        expect(subject.errors).to be_blank
      end

      # context "after save" do
      #   before { model_object.save }
      #   subject { model_object.class.first(order: "id DESC") }
      #   it 'is correct' do
      #     FactoryBot.attributes_for(model_name).keys.each do |attribute_name|
      #       expect(subject[attribute_name]).to eq attribute_name
      #     end
      #   end
      # end
    end
  end
end
