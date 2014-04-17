# encoding: utf-8

shared_examples 'lazy attribute' do
  describe '#lazy_method' do
    context 'the object is not fully loaded' do
      subject { partial_object }

      it 'loads the full and returns the lazy_value' do
        expect { subject.public_send(lazy_method) }.
          to change { subject.load_state }.from(:ghost).to(:loaded)
        expect(subject.public_send(lazy_method)).to eq(lazy_value)
      end
    end

    context 'the object is fully loaded' do
      before { subject.load_state = :loaded }

      subject { complete_object }

      it 'returns the subject lazy_value' do
        expect { subject.public_send(lazy_method) }.
          to_not change { subject.load_state }
        expect(subject.public_send(lazy_method)).to eq(lazy_value)
      end
    end
  end
end
