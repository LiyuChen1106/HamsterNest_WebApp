module UserProfilesHelper
  def getProvinceName(id)
    @province = Province.find(id)
    @province.province
  end
end
