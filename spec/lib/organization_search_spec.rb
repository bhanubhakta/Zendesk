# frozen_string_literal: true
require 'json'

Dir['./*/*.rb'].each do |file|
  require file
end

describe OrganizationSearch do
  let(:user_file) do
    File.expand_path('../../data_source/users.json', __FILE__)
  end

  let(:org_file) do
    File.expand_path('../../data_source/organizations.json', __FILE__)
  end

  let(:file_name) do
    File.expand_path('../../data_source/tickets.json', __FILE__)
  end

  before do
    stub_const('User::FILE_NAME', user_file)
    stub_const('Organization::FILE_NAME', org_file)
    stub_const('Ticket::FILE_NAME', file_name)
  end

  describe '#tickets' do
    subject { OrganizationSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': 101 } }

        it 'returns the associated tickets' do
          tickets = subject.tickets
          tic_subject = tickets.last['tickets'].last['subject']
          expect(tickets.count).to eq(1)
          expect(tic_subject).to eq('A Catastrophe in Micronesia')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.tickets.count).to eq(0)
        end
      end
    end
  end

  describe '#users' do
    subject { OrganizationSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': 101 } }

        it 'returns the associated users' do
          users = subject.users
          expect(users.count).to eq(1)
          expect(users.last['name']).to eq('Enthaze')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.users.count).to eq(0)
        end
      end
    end
  end
end

