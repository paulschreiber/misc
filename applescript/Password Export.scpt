FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ZT
macOS Keychain password exporter
Tested on Mojave (10.14.6) and Big Sur (11.1) on 2021-01-28
Copyright 2021 Paul Schreiber <https://paulschreiber.com/>
License: MIT License

1. Launch Keychain Access
2. Open the main window and close all other windows
3. Select the keychain (login, iCloud, etc.)
4. Select "Passwords"
5. Run this script

     � 	 	� 
 m a c O S   K e y c h a i n   p a s s w o r d   e x p o r t e r 
 T e s t e d   o n   M o j a v e   ( 1 0 . 1 4 . 6 )   a n d   B i g   S u r   ( 1 1 . 1 )   o n   2 0 2 1 - 0 1 - 2 8 
 C o p y r i g h t   2 0 2 1   P a u l   S c h r e i b e r   < h t t p s : / / p a u l s c h r e i b e r . c o m / > 
 L i c e n s e :   M I T   L i c e n s e 
 
 1 .   L a u n c h   K e y c h a i n   A c c e s s 
 2 .   O p e n   t h e   m a i n   w i n d o w   a n d   c l o s e   a l l   o t h e r   w i n d o w s 
 3 .   S e l e c t   t h e   k e y c h a i n   ( l o g i n ,   i C l o u d ,   e t c . ) 
 4 .   S e l e c t   " P a s s w o r d s " 
 5 .   R u n   t h i s   s c r i p t 
 
   
  
 l     ��������  ��  ��        j     �� �� 0 
mypassword 
myPassword  m        �    M Y _ P A S S W O R D !      j    �� �� 0 
outputfile 
outputFile  m       �    p a s s w o r d s . t x t      j    �� �� 0 tabkey tabKey  I   �� ��
�� .sysontocTEXT       shor  m    ���� 	��        j    �� �� 0 majorversion majorVersion  I   �� ��
�� .fndrgstl****    ��� ****  m       �    s y s 1��       !   j    �� "�� 0 minorversion minorVersion " I   �� #��
�� .fndrgstl****    ��� **** # m     $ $ � % %  s y s 2��   !  & ' & j    '�� (�� 0 ismojave isMojave ( F    & ) * ) =     + , + o    ���� 0 majorversion majorVersion , m    ���� 
 * =   ! $ - . - o   ! "���� 0 minorversion minorVersion . m   " #����  '  / 0 / j   ( 4�� 1�� 0 
iscatalina 
isCatalina 1 F   ( 3 2 3 2 =   ( + 4 5 4 o   ( )���� 0 majorversion majorVersion 5 m   ) *���� 
 3 =   . 1 6 7 6 o   . /���� 0 minorversion minorVersion 7 m   / 0����  0  8 9 8 j   5 ;�� :�� 0 isbigsur isBigSur : =   5 : ; < ; o   5 6���� 0 majorversion majorVersion < m   6 9����  9  = > = l     ��������  ��  ��   >  ? @ ? l     A���� A Z      B C���� B F      D E D H      F F o     ���� 0 ismojave isMojave E H   	  G G o   	 
���� 0 isbugsur isBugSur C I   �� H I
�� .sysodlogaskr        TEXT H m     J J � K K F N o t   t e s t e d   o n   t h i s   v e r s i o n   o f   m a c O S I �� L M
�� 
btns L m     N N � O O  C a n c e l M �� P��
�� 
dflt P m     Q Q � R R  C a n c e l��  ��  ��  ��  ��   @  S T S l     ��������  ��  ��   T  U V U l  a W���� W O   a X Y X O   "` Z [ Z k   )_ \ \  ] ^ ] Z   ) D _ `���� _ >   ) 2 a b a l  ) 0 c���� c I  ) 0�� d��
�� .corecnte****       **** d 2   ) ,��
�� 
cwin��  ��  ��   b m   0 1����  ` I  5 @�� e f
�� .sysodlogaskr        TEXT e m   5 6 g g � h h h E n s u r e   K e y c h a i n   A c c e s s   o n l y   h a s   t h e   m a i n   w i n d o w   o p e n f �� i j
�� 
btns i m   7 8 k k � l l  C a n c e l j �� m��
�� 
dflt m m   9 < n n � o o  C a n c e l��  ��  ��   ^  p q p l  E E��������  ��  ��   q  r s r I  E J������
�� .miscactvnull��� ��� null��  ��   s  t u t l  K K��������  ��  ��   u  v w v Z   K l x y z�� x o   K P���� 0 ismojave isMojave y r   S X { | { m   S T����  | o      ���� "0 scrollareaindex scrollAreaIndex z  } ~ } o   [ `���� 0 isbigsur isBigSur ~  ��  r   c h � � � m   c d����  � o      ���� "0 scrollareaindex scrollAreaIndex��  ��   w  � � � r   m � � � � I  m ��� ���
�� .corecnte****       **** � n   m � � � � 2   � ���
�� 
crow � n   m � � � � 4   } ��� �
�� 
outl � m   � �����  � n   m } � � � 4   v }�� �
�� 
scra � o   y |���� "0 scrollareaindex scrollAreaIndex � n   m v � � � 4   q v�� �
�� 
splg � m   t u����  � 4   m q�� �
�� 
cwin � m   o p���� ��   � o      ���� 0 passwordcount passwordCount �  � � � I  � ��� � �
�� .sysodlogaskr        TEXT � b   � � � � � b   � � � � � m   � � � � � � �   A b o u t   t o   e x p o r t   � o   � ����� 0 passwordcount passwordCount � m   � � � � � � �    p a s s w o r d s � �� � �
�� 
btns � J   � � � �  � � � m   � � � � � � �  C o n t i n u e �  ��� � m   � � � � � � �  C a n c e l��   � �� ���
�� 
dflt � m   � � � � � � �  C o n t i n u e��   �  � � � l  � ���������  ��  ��   �  � � � U   �] � � � k   �X � �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � ; 5 Get item name, location and account from Info window    � � � � j   G e t   i t e m   n a m e ,   l o c a t i o n   a n d   a c c o u n t   f r o m   I n f o   w i n d o w �  � � � I  � ��� ���
�� .prcsclicnull��� ��� uiel � n   � � � � � 4   � ��� �
�� 
menI � m   � � � � � � �  G e t   I n f o � n   � � � � � 4   � ��� �
�� 
menE � m   � � � � � � �  F i l e � 4   � ��� �
�� 
mbar � m   � ����� ��   �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 4   � ��� �
�� 
txtf � m   � �����  � n   � � � � � 4   � ��� �
�� 
tabg � m   � �����  � 4   � ��� �
�� 
cwin � m   � �����  � o      ���� 0 username   �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 4   � ��� �
�� 
txtf � m   � �����  � n   � � � � � 4   � ��� �
�� 
tabg � m   � �����  � 4   � ��� �
�� 
cwin � m   � �����  � o      ���� 0 site   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � &   close window (click red button)    � � � � @   c l o s e   w i n d o w   ( c l i c k   r e d   b u t t o n ) �  � � � I  �� ��~
� .prcsclicnull��� ��� uiel � n   � � � � 4  �} �
�} 
butT � m  �|�|  � 4   ��{ �
�{ 
cwin � m   �z�z �~   �  � � � l �y�x�w�y  �x  �w   �  � � � l �v � ��v   � M G need to click the button because clicking the menu item fails silently    � � � � �   n e e d   t o   c l i c k   t h e   b u t t o n   b e c a u s e   c l i c k i n g   t h e   m e n u   i t e m   f a i l s   s i l e n t l y �  � � � l �u � ��u   � ; 5 click menu item "Close" of menu "File" of menu bar 1    � � � � j   c l i c k   m e n u   i t e m   " C l o s e "   o f   m e n u   " F i l e "   o f   m e n u   b a r   1 �  � � � l �t�s�r�t  �s  �r   �  � � � l �q �q    N H get password by copying from keychain access and then authenticating			    � �   g e t   p a s s w o r d   b y   c o p y i n g   f r o m   k e y c h a i n   a c c e s s   a n d   t h e n   a u t h e n t i c a t i n g 	 	 	 �  I $�p�o
�p .prcsclicnull��� ��� uiel n    4   �n
�n 
menI m  		 �

 4 C o p y   P a s s w o r d   t o   C l i p b o a r d n   4  �m
�m 
menE m   �  E d i t 4  �l
�l 
mbar m  �k�k �o    l %, I %,�j�i
�j .sysodelanull��� ��� nmbr m  %( ?�      �i   ' ! wait for SecurityAgent to appear    � B   w a i t   f o r   S e c u r i t y A g e n t   t o   a p p e a r  O  -� Z  6��h o  6;�g�g 0 ismojave isMojave k  >_   !"! l >>�f#$�f  # R L On Mojave, SecurityAgent returns {} as its list of windows, so type instead   $ �%% �   O n   M o j a v e ,   S e c u r i t y A g e n t   r e t u r n s   { }   a s   i t s   l i s t   o f   w i n d o w s ,   s o   t y p e   i n s t e a d" &'& r  >E()( m  >?�e
�e boovtrue) 1  ?D�d
�d 
pisf' *+* I FO�c,�b
�c .prcskprsnull���     ctxt, o  FK�a�a 0 
mypassword 
myPassword�b  + -.- I PW�`/�_
�` .sysodelanull��� ��� nmbr/ m  PS00 ?��������_  . 1�^1 I X_�]2�\
�] .prcskprsnull���     ctxt2 o  X[�[
�[ 
ret �\  �^   343 o  bg�Z�Z 0 isbigsur isBigSur4 5�Y5 k  j�66 787 r  j}9:9 o  jo�X�X 0 
mypassword 
myPassword: n      ;<; 1  x|�W
�W 
valL< n  ox=>= 4  sx�V?
�V 
txtf? m  vw�U�U > 4  os�T@
�T 
cwin@ m  qr�S�S 8 A�RA I ~��QB�P
�Q .prcsclicnull��� ��� uielB n  ~�CDC 4  ���OE
�O 
butTE m  ��FF �GG  O KD 4  ~��NH
�N 
cwinH m  ���M�M �P  �R  �Y  �h   n  -3IJI 4  .3�LK
�L 
prcsK m  /2LL �MM  S e c u r i t y A g e n tJ m  -.NN�                                                                                  sevs  alis    R  avocado                        BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    a v o c a d o  -System/Library/CoreServices/System Events.app   / ��   OPO l ���K�J�I�K  �J  �I  P QRQ Q  ��STUS r  ��VWV l ��X�H�GX I ���F�EY
�F .JonsgClp****    ��� null�E  Y �DZ�C
�D 
rtypZ m  ���B
�B 
ctxt�C  �H  �G  W o      �A�A 
0 passwd  T R      �@�?�>
�@ .ascrerr ****      � ****�?  �>  U k  ��[[ \]\ l ���=^_�=  ^ . ( Mojave sometimes fails here. try again?   _ �`` P   M o j a v e   s o m e t i m e s   f a i l s   h e r e .   t r y   a g a i n ?] a�<a r  ��bcb l ��d�;�:d I ���9�8e
�9 .JonsgClp****    ��� null�8  e �7f�6
�7 
rtypf m  ���5
�5 
ctxt�6  �;  �:  c o      �4�4 
0 passwd  �<  R ghg r  ��iji l ��k�3�2k b  ��lml b  ��non b  ��pqp b  ��rsr o  ���1�1 0 site  s o  ���0�0 0 tabkey tabKeyq o  ���/�/ 0 username  o o  ���.�. 0 tabkey tabKeym o  ���-�- 
0 passwd  �3  �2  j o      �,�, 0 itemdata itemDatah tut r  ��vwv b  ��xyx l ��z�+�*z I ���){|
�) .earsffdralis        afdr{ 1  ���(
�( 
desk| �'}�&
�' 
rtyp} m  ���%
�% 
ctxt�&  �+  �*  y o  ���$�$ 0 
outputfile 
outputFilew o      �#�# $0 passwordfilepath passwordFilePathu ~~ r  ���� I ���"��
�" .rdwropenshor       file� o  ���!�! $0 passwordfilepath passwordFilePath� � ��
�  
perm� m  ���
� boovtrue�  � o      �� 0 passwordfile passwordFile ��� I ���
� .rdwrwritnull���     ****� b  ��� o  �� 0 itemdata itemData� l ���� I ���
� .sysontocTEXT       shor� m  	�� 
�  �  �  � ���
� 
refn� o  �� 0 passwordfile passwordFile� ���
� 
wrat� m  �
� rdwreof �  � ��� I &���
� .rdwrclosnull���     ****� o  "�� 0 passwordfile passwordFile�  � ��� l ''����  �  �  � ��� l ''�
���
  � %  bring Keychain Access to front   � ��� >   b r i n g   K e y c h a i n   A c c e s s   t o   f r o n t� ��� r  '.��� m  '(�	
�	 boovtrue� 1  (-�
� 
pisf� ��� I /6���
� .sysodelanull��� ��� nmbr� m  /2�� ?�      �  � ��� r  7P��� n  7L��� 4  GL��
� 
outl� m  JK�� � n  7G��� 4  @G��
� 
scra� o  CF�� "0 scrollareaindex scrollAreaIndex� n  7@��� 4  ;@��
� 
splg� m  >?� �  � 4  7;���
�� 
cwin� m  9:���� � o      ���� 	0 focus  � ��� l QQ��������  ��  ��  � ��� l QQ������  �   press the down arrow key   � ��� 2   p r e s s   t h e   d o w n   a r r o w   k e y� ���� I QX�����
�� .prcskcodnull���     ****� m  QT���� }��  ��   � o   � ����� 0 passwordcount passwordCount � ���� l ^^��������  ��  ��  ��   [ 4   " &���
�� 
prcs� m   $ %�� ���  K e y c h a i n   A c c e s s Y m    ���                                                                                  sevs  alis    R  avocado                        BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    a v o c a d o  -System/Library/CoreServices/System Events.app   / ��  ��  ��   V ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       ���  ��������������  � 	�������������������� 0 
mypassword 
myPassword�� 0 
outputfile 
outputFile�� 0 tabkey tabKey�� 0 majorversion majorVersion�� 0 minorversion minorVersion�� 0 ismojave isMojave�� 0 
iscatalina 
isCatalina�� 0 isbigsur isBigSur
�� .aevtoappnull  �   � ****� ���  	�� �� 
�� boovfals
�� boovfals
�� boovtrue� �����������
�� .aevtoappnull  �   � ****� k    a��  ?��  U����  ��  ��  �  � K���� J�� N�� Q������������ g k n�������������� � � � � ����� ��� �����������������	��L����0��F������������������������������������������������ 0 isbugsur isBugSur
�� 
bool
�� 
btns
�� 
dflt�� 
�� .sysodlogaskr        TEXT
�� 
prcs
�� 
cwin
�� .corecnte****       ****
�� .miscactvnull��� ��� null�� "0 scrollareaindex scrollAreaIndex
�� 
splg
�� 
scra
�� 
outl
�� 
crow�� 0 passwordcount passwordCount
�� 
mbar
�� 
menE
�� 
menI
�� .prcsclicnull��� ��� uiel
�� 
tabg
�� 
txtf
�� 
valL�� 0 username  �� �� 0 site  
�� 
butT
�� .sysodelanull��� ��� nmbr
�� 
pisf
�� .prcskprsnull���     ctxt
�� 
ret 
�� 
rtyp
�� 
ctxt
�� .JonsgClp****    ��� null�� 
0 passwd  ��  ��  �� 0 itemdata itemData
�� 
desk
�� .earsffdralis        afdr�� $0 passwordfilepath passwordFilePath
�� 
perm
�� .rdwropenshor       file�� 0 passwordfile passwordFile�� 

�� .sysontocTEXT       shor
�� 
refn
�� 
wrat
�� rdwreof 
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****�� 	0 focus  �� }
�� .prcskcodnull���     ****��bb  	 ��& ������ Y hO�@*��/8*�-j k ����a � Y hO*j Ob   
kE` Y b   
lE` Y hO*�k/a k/a _ /a k/a -j E` Oa _ %a %�a a lv�a � O�_ kh*a k/a a /a  a !/j "O*�k/a #k/a $�/a %,E` &O*�k/a #k/a $a '/a %,E` (O*�k/a )k/j "O*a k/a a */a  a +/j "Oa ,j -O��a ./ ]b   &e*a /,FOb   j 0Oa 1j -O_ 2j 0Y 1b   (b   *�k/a $k/a %,FO*�k/a )a 3/j "Y hUO *a 4a 5l 6E` 7W X 8 9*a 4a 5l 6E` 7O_ (b  %_ &%b  %_ 7%E` :O*a ;,a 4a 5l <b  %E` =O_ =a >el ?E` @O_ :a Aj B%a C_ @a Da E� FO_ @j GOe*a /,FOa ,j -O*�k/a k/a _ /a k/E` HOa Ij J[OY�YOPUUascr  ��ޭ