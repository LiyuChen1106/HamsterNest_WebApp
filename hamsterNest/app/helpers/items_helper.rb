module ItemsHelper
  def itemAvaiableMessage(x)
    x ? "This item is currently avaiable" : "This item is currently unavailable"
  end

  def getCategoryName(id)
    #@category = Category.find(id)
    #@category.category_name
  end
end
