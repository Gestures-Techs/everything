from lxml import etree

# Example Android UI XML
xml = """
<hierarchy xmlns:android="http://schemas.android.com/apk/res/android">
  <android.widget.FrameLayout
      android:id="@android:id/content"
      android:clickable="true"
      android:contentDescription="Account and settings." />
</hierarchy>
"""

# Parse the XML
root = etree.fromstring(xml)

# Define the namespace mapping
ns = {'android': 'http://schemas.android.com/apk/res/android'}

# Test your XPath
xpath_expr = "//android.widget.FrameLayout[@android:clickable='true']"
result = root.xpath(xpath_expr, namespaces=ns)

print("Matched elements:", len(result))
for r in result:
    print(etree.tostring(r, pretty_print=True).decode())
