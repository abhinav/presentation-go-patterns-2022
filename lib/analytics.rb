class GoogleAnalyticsDocinfoProcessor < Asciidoctor::Extensions::DocinfoProcessor
  use_dsl
  at_location :head
  def process document
    return unless (ga_account_id = document.attr 'google-analytics-id')
    %(<script async src="https://www.googletagmanager.com/gtag/js?id=#{ga_account_id}"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', '#{ga_account_id}');
    </script>)
  end
end

Asciidoctor::Extensions.register do
  docinfo_processor GoogleAnalyticsDocinfoProcessor
end
