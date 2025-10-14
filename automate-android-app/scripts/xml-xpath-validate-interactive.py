from lxml import etree

xml = open("ui_dump.xml").read()  # your Android UI XML dump
root = etree.fromstring(xml)
ns = {'android': 'http://schemas.android.com/apk/res/android'}








# Store multiple XPath expressions in a list
xpath_exprs = [
    # "//android.view.View[contains(@android:clickable,'true')]",
    # "/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/android.widget.FrameLayout[@android:id='@android:id/content']/android.widget.FrameLayout[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/android.widget.FrameLayout[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/androidx.compose.ui.platform.ComposeView[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/android.view.View/android.view.View/android.view.View/android.view.View/android.view.View/iuk/android.widget.FrameLayout[@android:contentDescription='Account and settings.']"
    # "//android.widget.FrameLayout[@android:clickable='true']",
    # "//android.widget.LinearLayout[@android:clickable='false']",
    # "//android.widget.FrameLayout[@android:contentDescription='Account and settings']",
    # "//android.widget.FrameLayout[contains(@android:contentDescription,'Account')]" # working
    "(//android.widget.FrameLayout[contains(@android:contentDescription,'Account')])[1]",
    "(//android.widget.FrameLayout[contains(@android:contentDescription,'Account')])[last()]",
    "(//android.widget.FrameLayout[contains(@android:contentDescription,'Account and settings')])[last()]",
    "(//android.widget.TextView[contains(@android:text,'My apps')])[last()]",
    "(//android.widget.TextView[contains(@android:text,'My apps')]/ancestor::android.view.ViewGroup[@android:clickable='true'])[last()]"
]

# Run them one by one
for expr in xpath_exprs:
    result = root.xpath(expr, namespaces=ns)
    print(f"XPath: {expr}")
    print("Matched elements:", len(result))
    for r in result:
        print(etree.tostring(r, pretty_print=True).decode())
    print("------------------------------------------------")