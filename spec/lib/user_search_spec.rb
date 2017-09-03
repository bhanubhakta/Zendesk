# frozen_string_literal: true

require 'json'

Dir['./*/*.rb'].each do |file|
  require file
end

describe UserSearch do
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
    subject { UserSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': 1 } }

        it 'returns the associated organization' do
          organizations = subject.organizations
          expect(organizations.count).to eq(1)
          expect(organizations.last['organization']['name']).to eq('Enthaze')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.organizations.count).to eq(0)
        end
      end
    end
  end

  describe '#worked_tickets' do
    subject { UserSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': 1 } }

        it 'returns the associated assignee tickets' do
          worked_tickets = subject.worked_tickets
          tic_subject = worked_tickets.last['assigned_tickets'].last['subject']
          expect(worked_tickets.count).to eq(1)
          expect(tic_subject).to eq('A Catastrophe in Micronesia')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.worked_tickets.count).to eq(0)
        end
      end
    end
  end

  describe '#submitted_tickets' do
    subject { UserSearch.new(field_value) }
    context 'field_value' do
      context 'matching value' do
        let(:field_value) { { '_id': 1 } }

        it 'returns the associated submitted tickets' do
          submitted_tickets = subject.submitted_tickets
          tic_subject = submitted_tickets.last['submitted_tickets'].last['subject']
          expect(submitted_tickets.count).to eq(1)
          expect(tic_subject).to eq('A Catastrophe in Korea (North)')
        end
      end

      context 'no matching value' do
        let(:field_value) { { '_id': 52 } }

        it 'does not return any record' do
          expect(subject.submitted_tickets.count).to eq(0)
        end
      end
    end
  end
end
