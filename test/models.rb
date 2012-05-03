class AutomobileVariantGuru
  def transmission_is_blank?(row)
    row['transmission'].blank?
  end

  def is_a_2007_gmc_or_chevrolet?(row)
    row['year'] == 2007 and %w(GMC CHEVROLET).include? row['MFR'].upcase
  end

  def is_a_porsche?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v.upcase == 'PORSCHE' }
  end

  def is_not_a_porsche?(row)
    !is_a_porsche? row
  end

  def is_a_mercedes_benz?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v =~ /MERCEDES/i }
  end

  def is_a_lexus?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v.upcase == 'LEXUS' }
  end

  def is_a_bmw?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v.upcase == 'BMW' }
  end

  def is_a_ford?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v.upcase == 'FORD' }
  end

  def is_a_bentley?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v.upcase == 'BENTLEY' }
  end

  def is_a_rolls_royce?(row)
    row.slice('MFR', 'Manufacturer', 'carline_mfr_name').any? { |k, v| v =~ /ROLLS/i }
  end

  def is_a_turbo_brooklands?(row)
    row.slice('CAR LINE', 'carline name', 'carline_name').any? { |k, v| v =~ /TURBO R\/RL BKLDS/i }
  end

  def model_contains_maybach?(row)
    row.slice('CAR LINE', 'carline name', 'carline_name').any? { |k, v| v =~ /MAYBACH/i }
  end
  
  def model_contains_bentley?(row)
    row.slice('CAR LINE', 'carline name', 'carline_name').any? { |k, v| v =~ /BENTLEY/i }
  end
end
