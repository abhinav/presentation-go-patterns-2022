class CloudflareWebAnalyticsProcessor < Asciidoctor::Extensions::DocinfoProcessor
  use_dsl
  at_location :footer
  def process document
    return unless (cf_wa_token = document.attr 'cloudflare-wa-token')
    %(<!-- Cloudflare Web Analytics -->
    <script defer src='https://static.cloudflareinsights.com/beacon.min.js' data-cf-beacon='{"token": "#{cf_wa_token}"}'></script>
    <!-- End Cloudflare Web Analytics -->)
  end
end

Asciidoctor::Extensions.register do
  docinfo_processor CloudflareWebAnalyticsProcessor
end
