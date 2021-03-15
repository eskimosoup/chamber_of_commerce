# frozen_string_literal: true

module CsvExports
  class MembershipPaymentsService < BaseService
    private

    #
    # Override the column names method from the base service, used for CSV headers
    #
    # @return [array]
    #
    def column_names
      case csv_columns
      when 'index'
        index_column_names
      else
        collection.first.class.column_names if collection.present?
      end
    end

    #
    # Create a flattened array of fields to use for the CSV
    #
    # @return [array]
    #
    def index_column_names
      [
        [collection.first.class.column_names.reject { |column| index_rejected_columns.include?(column) }],
        %w[how_heard_titles join_reason_titles stripe_payment_intent_id]
      ].flatten
    end

    #
    # Field names to reject
    #
    # @return [array]
    #
    def index_rejected_columns
      %w[stripe_charge_id stripe_payment_intent_id memberships_package_id hashed_id]
    end
  end
end
