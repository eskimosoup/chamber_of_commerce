class Member::Import
  include ActiveModel::Model
  attr_accessor :file, :imported_count, :updated_count

  def process!
    @imported_count = 0
    @updated_count = 0
    Member.update_all(in_csv: false)
    CSV.foreach(file.path, headers: true, header_converters: :symbol, encoding: 'windows-1251:utf-8') do |row|
      member = assign_member_from_csv_row(row)
      new_record = member.new_record?
      if member.save!
        if new_record
          @imported_count += 1
        else
          @updated_count += 1
        end
      else
        # $. gets last line read in
        errors.add(:base, "Line #{$INPUT_LINE_NUMBER} - #{member.errors.full_messages.join(', ')}")
      end
    end
  end

  def save
    process!
    errors.none?
  end

  def self.tidy
    Member.unscoped.select("DISTINCT ON(members.company_name) members.*").each do |member|
      p member.id
      other_ids = Member.unscoped.where(chamber_db_id: member.chamber_db_id).where.not(id: member.id).pluck(:id)

      verified = Member.where(chamber_db_id: member.chamber_db_id, verified: true).present?
      member.update_attributes(verified: verified)

      next unless other_ids.present?

      MemberOffer.where(member_id: other_ids).update_all(member_id: member.id)
      MemberLogin.where(member_id: other_ids).update_all(member_id: member.id)
      Member.unscoped.where(id: other_ids).destroy_all
    end
  end

  def make_hash_from_row(row)
    member_details_hash = row.to_hash.slice(:company_name, :post_code, :tel_no, :fax_no, :www, :email_no, :nature_of_business)
    member_details_hash[:address] = [row[:address_1], row[:addres_2], row[:address_3], row[:addres_4], row[:town], row[:county]].compact.join("\n")
    member_details_hash = manipulate_hash_keys(member_details_hash)
    member_details_hash
  end

  private

  def assign_member_from_csv_row(row)
    member_details = make_hash_from_row(row)
    member = Member.unscoped.find_or_initialize_by(chamber_db_id: row[:id_no])
    member.assign_attributes(member_details.merge(in_csv: true))
    member
  end

  def manipulate_hash_keys(hash)
    hash[:telephone] = hash.delete(:tel_no)
    hash[:fax] = hash.delete(:fax_no)
    hash[:email] = hash.delete(:email_no)
    hash[:website] = hash.delete(:www)
    hash
  end
end
