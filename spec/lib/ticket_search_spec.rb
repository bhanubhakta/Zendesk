# frozen_string_literal: true
require 'json'

Dir['./*/*.rb'].each do |file|
  require file
end

describe TicketSearch do
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

  describe '#organization' do
    subject { TicketSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': '436bf9b0-1147-4c0a-8439-6f79833bff5b' } }

        it 'returns the associated organization' do
          organization = subject.organization
          expect(organization.count).to eq(1)
          expect(organization.last['organization']['name']).to eq('Nutralab')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.organization.count).to eq(0)
        end
      end
    end
  end

  describe '#assignee' do
    subject { TicketSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': '436bf9b0-1147-4c0a-8439-6f79833bff5b' } }

        it 'returns the associated assignee user' do
          submitter = subject.assignee
          expect(submitter.count).to eq(1)
          expect(submitter.last['assignee']['name']).to eq('Cross Barlow')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.assignee.count).to eq(0)
        end
      end
    end
  end

  describe '#submitter' do
    subject { TicketSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': '436bf9b0-1147-4c0a-8439-6f79833bff5b' } }

        it 'returns the associated submitters' do
          submitter = subject.submitter
          expect(submitter.count).to eq(1)
          expect(submitter.last['submitter']['name']).to eq('Francisca Rasmussen')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.submitter.count).to eq(0)
        end
      end
    end
  end
end
