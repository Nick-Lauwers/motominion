# complete

module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    
    base_title = "Motominion"
    
    if page_title.empty?
      base_title
      
    else
      page_title + " • " + base_title
    end
  end
  
  # Returns the meta description on a per-page basis.
  def meta_description(page_description = '')
    if page_description.empty?
      "Browse new and used motorcycle listings to find the best local deals. Search available models from Harley-Davidson, Honda, Yamaha, Polaris, Kawasaki, and more."
    else
      page_description
    end
  end
  
  # Pluralizes without count
  def pluralize_without_count(count, noun, text = nil)
    if count != 0
      count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
    end
  end
  
  # Returns Stripe payout path
  def stripe_express_path
    "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_BD8r53QcoGgaAFIftErGpz8z6PnJWA5p&scope=read_write"
  end
end