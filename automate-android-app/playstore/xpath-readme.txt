<root xmlns:foo="http://www.foo.org/" xmlns:bar="http://www.bar.org">
	<actors>
		<actor id="1">Christian Bale</actor>
		<actor id="2">Liam Neeson</actor>
		<actor id="3">Michael Caine</actor>
	</actors>
	<foo:singers>
		<foo:singer id="4">Tom Waits</foo:singer>
		<foo:singer id="5">B.B. King</foo:singer>
		<foo:singer id="6">Ray Charles</foo:singer>
	</foo:singers>
</root>


1. Select the document node
/

2. Select the 'root' element
/root

3. Select all 'actor' elements that are direct children of the 'actors' element
/root/actors/actor

4. Select all 'singer' elements regardless of their positions in the document
//foo:singer

5. Select the 'id' attributes of the 'singer' elements regardless of their positions in the document
//foo:singer/@id

6. Select the textual value of first 'actor' element
//actor[1]/text()

7. Select the last 'actor' element
//actor[last()]

8. Select the first and second 'actor' elements using their position
//actor[position() < 3]

9. Select all 'actor' elements that have an 'id' attribute
//actor[@id]]

10. Select the 'actor' element with the 'id' attribute value of '3'
//actor[@id='3']

11. Select all 'actor' nodes with the 'id' attribute value lower or equal to '3'
//actor[@id<=3]

12. Select all the children of the 'singers' node
/root/foo:singers/*

13. Select all the elements in the document
//*

14. Select all the 'actor' elements AND the 'singer' elements
//actor|//foo:singer

15. Select the name of the first element in the document
name(//*[1])

16. Select the numeric value of the 'id' attribute of the first 'actor' element
number(//actor[1]/@id)

17. Select the string representation value of the 'id' attribute of the first 'actor' element
string(//actor[1]/@id)

18. Select the length of the first 'actor' element's textual value
string-length(//actor[1]/text())

19. Select the local name of the first 'singer' element, i.e. without the namespace
local-name(//foo:singer[1])

20. Select the number of 'singer' elements
count(//foo:singer)

21. Select the sum of the 'id' attributes of the 'singer' elements
sum(//foo:singer/@id)

//*[@desc="Account and settings."]
//*[fn:matches(@desc, "Account and settings")]

//*[contains(@contentDescription, "Account and settings")]

//*[contains(@contentDescription, "Account and settings")]




//*[contains(@contentDescription, "Account and settings")]



//iuk//android.widget.FrameLayout[@contentDescription="Account and settings."]


//iuk//android.widget.FrameLayout[@android:clickable='true']


//android.widget.FrameLayout[@contentDescription="Account and settings."]'


//*[@android:contentDescription="Account and settings."]


[attribute = 'value'] - Selects all elements with a given attribute value
Example: //*[@id='uniqueElement'] selects all elements with an id attribute equal to "uniqueElement".
[contains(attribute, 'text')] - Selects elements with an attribute containing 'text'
Example: //div[contains(@class, 'note')] selects all <div> elements whose class attribute contains the word "note".

//android.view.View[contains(@android:clickable, 'true')]
















------------------------------------------------------------------------------------






verfied and working 

//android.view.View[@android:clickable='true']


"/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/android.widget.FrameLayout[@android:id='@android:id/content']/android.widget.FrameLayout[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/android.widget.FrameLayout[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/androidx.compose.ui.platform.ComposeView[@android:id='@com.android.vending:id/0_resource_name_obfuscated']/android.view.View/android.view.View/android.view.View/android.view.View/android.view.View/iuk/android.widget.FrameLayout[@android:contentDescription='Account and settings.']"


//actor[@contentDescription='test']



//*[contains(@contentDescription, 'test')]
Element='<actor contentDescription="test sure" id="3"> Michael Caine</actor>'





//*[contains(@contentDescription, 'Account and settings')]
Element='<actor contentDescription="Signed in as Rahul Parmar rahulparmar.n1798@gmail.com&#xA;Google One account.&#xA;Account and settings."
       id="3"> Michael Caine</actor>'



[contains(attribute, 'text')] - Selects elements with an attribute containing 'text'
Example: //div[contains(@class, 'note')] selects all <div> elements whose class attribute contains the word "note".