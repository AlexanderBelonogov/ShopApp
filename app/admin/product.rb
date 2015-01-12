ActiveAdmin.register Product do
  permit_params :name, :description, :price, :image, :category_ids => []

  form(:html => { :multipart => true }) do |f|
    f.inputs "New Product" do
      f.input :name
      f.input :description
      f.input :categories, as: :check_boxes
      f.input :price
      f.input :image, :as => :file
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :name
      row :description
      row :price do
        build_currency(product.price)
      end
      row :categories do
        product.categories.map(&:name).join(', ')
      end
      row :image do
        image_tag(product.image_url.present? ? product.image_url : 'image_not_available_big.gif', width: 175, height: 175)
      end
    end
    active_admin_comments
  end
end
