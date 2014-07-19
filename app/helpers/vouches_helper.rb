module VouchesHelper
  def request_vouch_link
    new_polymorphic_path([parent,Vouch.new], :view => "requested")
  end

  def give_vouch_link
    new_polymorphic_path([parent,Vouch.new], :view => "given")
  end

  %w(all_vouches received granted requested pending).each do |view|
    module_eval <<-EOT, __FILE__, __LINE__ + 1
      def vouches_#{view}_page?
        params[:view] == "#{view}"
      end

      def vouches_#{view}_link
        link_to '#{view.titleize}', polymorphic_path([parent,Vouch.new], :view => "#{view}")
      end
    EOT
  end
end
