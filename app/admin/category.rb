ActiveAdmin.register Category do
  permit_params :name, :position
  
  index do
    column :id
    column :name
    column :position do |category|
      link_to('Up', change_position_category_path(category, move: 'up'), method: :post, style: 'text-decoration: none; margin-right: 5px;') +
      " #{category.position} " +
      link_to('Down', change_position_category_path(category, move: 'down'), method: :post, style: 'text-decoration: none;margin-left: 5px;')
    end
    column :updated_at
  end
  
end
