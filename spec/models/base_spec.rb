# frozen_string_literal: true
require File.expand_path('../../../models/base.rb', __FILE__)
require 'json'
describe Base do
  before do
    stub_const('Base::DATATYPES', '_id': 'integer', 'name': 'string', 'alias': 'string')
  end

  describe '#all' do
    subject { Base.new.all }
    context 'with incorrect file name(data source)' do
      before do
        stub_const('Base::FILE_NAME', './data_source/abc.json')
      end

      it 'throws an exception' do
        expect { subject }.to raise_error
      end
    end

    context 'with correct file name(data source)' do
      before do
        stub_const('Base::FILE_NAME', File.expand_path('../../data_source/users.json', __FILE__))
      end

      it 'gives all the records' do
        expect(subject.count).to equal(2)
      end
    end
  end

  describe '#where' do
    before do
      stub_const('Base::FILE_NAME', File.expand_path('../../data_source/users.json', __FILE__))
    end

    subject { Base.new.where(field_value) }
    context 'when field is not in the record' do
      let(:field_value) { { 'not_field': 1 } }
      it 'gives no result' do
        expect(subject.count).to equal(0)
      end
    end

    context 'when field is in the record' do
      context 'the value matches' do
        context 'and the value is integer' do
          let(:field_value) { { '_id': 1 } }
          it 'gives the exact matching result' do
            expect(subject.count).to equal(1)
            expect(subject.last['name']).to eq('Francisca Rasmussen')
          end
        end

        context 'and the value is string' do
          let(:field_value) { { alias: 'Miss' } }
          it 'gives the record containing that substring' do
            expect(subject.count).to eq(2)
            expect(subject.last['name']).to eq('Cross Barlow')
          end
        end
      end
    end
  end
end
