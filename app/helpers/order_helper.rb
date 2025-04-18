module OrderHelper
    def button_class(order)
      case order.status
      when 'pending'
        'primary'
      when 'cancelled'
        'danger'
      when 'delivered'
        'success'
      when 'shipped'
        'info'
      else
        'primary'
      end
    end
  end