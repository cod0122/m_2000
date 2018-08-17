$PBExportHeader$kuf_cripta.sru
$PBExportComments$Encrypts and decrypts strings
forward
global type kuf_cripta from nonvisualobject
end type
end forward

global type kuf_cripta from nonvisualobject
end type
global kuf_cripta kuf_cripta

type variables
string is_raw, is_encrypted, is_key="CGI"


end variables

forward prototypes
public function string of_set (string thestr)
public function STRING of_getraw ()
public function STRING of_getencrypted ()
public function string of_decrypt (string thestr)
public function string of_setkey (string thekey)
public function string of_set (string thetext, string thekey)
public function string of_decrypt (string thetext, string thekey)
private subroutine readme_doc ()
public function string of_decrypt_old (string thestr)
end prototypes

public function string of_set (string thestr);string retVal, tempStr, tStr
int sourcePtr, keyPtr, keyLen, sourceLen, tempVal, tempKey

retVal = is_raw
is_raw = thestr

keyPtr = 1
keyLen = LenA(is_key)
sourceLen = LenA(is_raw)
is_encrypted = ""
for sourcePtr = 1 to sourceLen
	tempVal = AscA(RightA(is_raw, sourceLen - sourcePtr + 1))
	tempKey = AscA(RightA(is_key, keyLen - keyPtr + 1))
	tempVal += tempKey
	// Added this section to ensure that ASCII Values stay within 0 to 255 range
	DO WHILE tempVal > 255
		if tempVal > 255 then
			tempVal = tempVal - 255
		end if
	LOOP
	// End of Section

//17-03-2007	tStr = CharA(tempVal)
tStr = string(tempVal,"000") 

	is_encrypted += tStr
	keyPtr ++
	if keyPtr > LenA(is_key) then keyPtr = 1
next

return is_encrypted
end function

public function STRING of_getraw ();return is_raw
end function

public function STRING of_getencrypted ();return is_encrypted
end function

public function string of_decrypt (string thestr);string retVal, tempStr, tStr
int sourcePtr, keyPtr, keyLen, sourceLen, tempVal, tempKey

is_encrypted = thestr

keyPtr = 1
keyLen = LenA(is_key)
// Fixed so that decryption is done on encrypted input string of proper length
//sourceLen = len(is_raw)

//27-03-2007
string k_password="", k_pass
int k_ctr=1, k_pass_int
do while k_ctr < LenA(thestr)
	k_pass_int =(integer(mid(thestr, k_ctr, 3)))
	k_pass = charA(k_pass_int)
	k_password += k_pass
	k_ctr += 3
loop
is_encrypted = k_password

sourceLen = LenA(is_encrypted)
tStr = string(tempVal,"000")

is_raw = ""
for sourcePtr = 1 to sourceLen
	tempVal = AscA(RightA(is_encrypted, LenA(is_encrypted) - sourcePtr + 1))
	tempKey = AscA(RightA(is_key, LenA(is_key) - keyPtr + 1))
	tempVal -= tempKey
	// Added this section to ensure that ASCII codes stay in 0 to 255 range
	DO WHILE tempVal < 0
		if tempVal < 0 then
			tempVal = tempVal + 255
		end if
	LOOP
	// end of section
	tStr = CharA(tempVal)
	is_raw += tStr
	keyPtr ++
	if keyPtr > LenA(is_key) then keyPtr = 1
next

retVal = is_raw

return retVal
end function

public function string of_setkey (string thekey);string retVal
retVal = is_key
is_key = theKey
return retVal
end function

public function string of_set (string thetext, string thekey);of_setKey(theKey)
return of_set(theText)
end function

public function string of_decrypt (string thetext, string thekey);// Chagned input variable order to match documentation

of_setKey(theKey)
return of_decrypt(theText)
end function

private subroutine readme_doc ();//
//--- DOCUMENTAZIONE
//
//The vl_cst_encryptor Object
//
//	This object is used to encrypt and decrypt strings.  It comes in handy for storing sensitive data in ini files.  The algorithm is almost impossible to break.  It depends upon a key that you supply.  Without that key the possible permutations make this almost unbeatable... even if you have the direct source code for the object it is still impossible to break.
//	The key to encrypting data is to use a key and then substitute characters one by one in each key.  Let us take a simple example.  We will take the value 'the quick brown' and encrypt it using the key 'my super key'.  The encryptor object will add the ASCII values of the raw data (the quick brown) to the ASCII value of the key to determine the encrypted value.  The figure below demonstrates this.
//
//t	h	e		q	u	i	c	k	b	r	o	w	n
//116	104	101	32	113	117	105	99	107	98	114	111	119	110
//m	y		s	u	p	e	r		k	e	y		m
//109	121	32	115	117	112	101	114	32	107	101	121	32	109
//													
//225	225	133	147	230	229	206	213	139	205	215	232	151	219
//ß	ß	à	ô	µ	s	+	+	ï	-	+	F	ù	¦
//
//	The first row in the figure is the raw text.  The second row shows the ASCII value for each of the characters in the text.  The third row is the key.  Note that in the last character the key is beginning to repeat.  The fourth row shows the ASCII values for each of the key characters.  I have left the fifth row blank to set apart the key and raw text from the result.
//	The sixth row shows the sum of the second and the fourth rows.  Those are the ASCII values for each character of the raw and the key respectively.  The final row shows the display character for the newly encrypted data.
//	There are a few things to note when looking at this table.  The first two characters in the raw text is translated to ascii 225.  This is significant because the first two characters are an 'm' followed by a 'y'.  Even though they are two different characters they translate to the same character.
//	Without the knowledge of this key it is literally impossible to have the code broken.  The disadvantage to that is that if you ever forget the key then the data is absolutely irretrievable.
//
//
//Mechanics
//
//	As mentioned earlier there are three values that are kept.  The raw, the encrypted, and the key.  Each of these are strings that are stored as instance variables in the object.
//	Functions are used to set each of these values.  These values, once set, are carried around until replaced.  That means that you can encrypt one value and carry it around, having access to either the raw or the encrypted data at any time.
//	The first step is to create the object.  This is done with the PowerBuilder create function.
//
//vl_cst_encryptor myEncryptor
//myEncryptor = create vl_cst_encryptor
//
//	The next step is to either accept the key that is defaulted or to change it.
//
//myEncryptor.of_setKey("MySpEcIaLkEy")
//
//	The only things that are left to be done is to call of_set and of_decrypt whenever we want to perform an action on the values.
//
//Functions
//
//string of_decrypt(string theText, string theKey)
//	This will unencrypt whatever string is passed in using theKey as the key.  It returns the old raw value for the object.
//string of_decrypt(string theText)
//	This decrypts the string passed in using the current key.  It returns the old raw value which it resets with the decrypted value.
//string of_getEncrypted()
//	This returns the encrypted string.
//string of_getRaw()
//	This returns the unencrypted or raw string.
//string of_set(string theText, string theKey)
//	This sets the raw value, the encrypted value, and the key.
//string of_set(string theText)
//	This uses the current key value to set the raw and encrypted values.
//string of_setKey(string theKey)
//	This sets the translation key and re-translates the raw value, thus generating a new encrypted value.  It returns the last key.
//
//Bugs Fixed:  (By James Rasmussen)
//Email responses to jrasmussen@mindspring.com
//
//1.	Decrypt Function did not work properly if you had not just encrypted the string.  Length of decryption was based on length of old raw string, not new encrypted string that is to be decrypted.  This has been fixed.
//2.	Decrypt Function that includes key had input variables reversed.  Function now works the way above documentation shows.
//3.	Encrypt/Decrypt Functions did not allways keep ASCII codes in 0 to 255 range.  This has now been fixed.
//
//
end subroutine

public function string of_decrypt_old (string thestr);string retVal, tempStr, tStr
int sourcePtr, keyPtr, keyLen, sourceLen, tempVal, tempKey

is_encrypted = thestr

keyPtr = 1
keyLen = LenA(is_key)
// Fixed so that decryption is done on encrypted input string of proper length
//sourceLen = len(is_raw)


sourceLen = LenA(is_encrypted)
tStr = string(tempVal,"000")

is_raw = ""
for sourcePtr = 1 to sourceLen
	tempVal = AscA(RightA(is_encrypted, LenA(is_encrypted) - sourcePtr + 1))
	tempKey = AscA(RightA(is_key, LenA(is_key) - keyPtr + 1))
	tempVal -= tempKey
	// Added this section to ensure that ASCII codes stay in 0 to 255 range
	DO WHILE tempVal < 0
		if tempVal < 0 then
			tempVal = tempVal + 255
		end if
	LOOP
	// end of section
	tStr = CharA(tempVal)
	is_raw += tStr
	keyPtr ++
	if keyPtr > LenA(is_key) then keyPtr = 1
next

retVal = is_raw

return retVal
end function

on kuf_cripta.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_cripta.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

