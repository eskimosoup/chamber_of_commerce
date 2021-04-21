module Optimadmin
  module Memberships
    class PaymentsController < Optimadmin::BaseController
      before_action :set_payment, only: %i[show edit update destroy]

      def index
        @payments = ::Memberships::Payment.field_order('created_at desc')
                                          .field_search(params[:search], 'company_name')
                                          .pagination(params[:page], params[:per_page])

        respond_to do |format|
          format.html
          format.csv { csv_data }
        end
      end

      def show; end

      def update
        member = Member.find_by(chamber_db_id: params[:chamber_db_id].to_i)
        if member.blank?
          redirect_to(
            { action: :show },
            flash: { error: 'Member with Chamber DB ID does not exist, please double check you have imported the member and try again.' }
          )
        elsif member.member_login.find_by(username: @payment.primary_contact_email_address)
          redirect_to(
            { action: :show },
            flash: { notice: 'Member login already exists.' }
          )
        else
          create_member_login(member)

          redirect_to(
            { action: :show },
            flash: { notice: 'Member login created successfully.' }
          )
        end
      end

      private

      def create_member_login(member)
        member.update!(verified: true)

        member_login = member.member_login.create(
          active: true,
          contact_name: [
            @payment.primary_contact_forename,
            @payment.primary_contact_surname
          ].join(' '),
          password: Digest::SHA1.hexdigest([Time.now, rand].join)[0..25],
          username: @payment.primary_contact_email_address
        )

        member_login.generate_reset_token
        MembershipsMailer.new_member_login(member_login).deliver_now
      end

      def csv_data
        send_data(
          csv,
          type: 'text/csv; charset=iso-8859-1; header=present',
          disposition: 'attachment',
          filename: 'membership-payments.csv'
        )
      end

      def csv
        ::CsvExports::MembershipPaymentsService.new(
          ::Memberships::Payment.all, 'index'
        ).to_csv
      end

      def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
        redirect_to(
          fallback_location,
          notice: (flash.present? ? flash[:error] : notice)
        )
      end

      def set_payment
        @payment = ::Memberships::Payment.find_by(hashed_id: params[:id])
      end
    end
  end
end
