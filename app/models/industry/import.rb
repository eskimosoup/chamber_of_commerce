class Industry::Import
  include ActiveModel::Model
  attr_accessor :file, :imported_count, :updated_count

  def industry_members
    @industry_members || Hash.new { |h, k| h[k] = [] }
  end

  def process!
    @imported_count = 0
    @updated_count = 0
    industry_members = build_industry_members_from_csv

    industry_members.each do |industry_name, member_ids|
      industry = Industry.find_or_initialize_by(name: industry_name)
      new_record = industry.new_record?
      industry.members = Member.where(chamber_db_id: member_ids.uniq)
      if industry.save
        if new_record
          @imported_count += 1
        else
          @updated_count += 1
        end
      else
        errors.add(:base, "Line #{$INPUT_LINE_NUMBER} - #{industry.errors.full_messages.join(', ')}")
      end
    end
  end

  def build_industry_members_from_csv
    CSV.foreach(file.path, headers: true, header_converters: :symbol, encoding: 'windows-1251:utf-8') do |row|
      add_row_to_industry_members(row)
    end
    industry_members
  end

  def add_row_to_industry_members(row)
    row_hash = row.to_hash
    add_member(row_hash[:heading], row_hash[:id_no])
  end

  def add_member(key, value)
    members = industry_members
    members[key] << value
    @industry_members = members
  end

  def save
    process!
    errors.none?
  end
end
