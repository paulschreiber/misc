FasdUAS 1.101.10   ��   ��    k             l      ��  ��   y
  Stubborn file remover
  by Paul Schreiber
  http://paulschreiber.com/
  web@paulschreiber.com
  
  requires Mac OS X. tested on 10.2.1, but should work on earlier versions.
  
  2 November 2002 -- 1.0
   -- initial release
   
  9 November 2002 -- 1.1
    -- now handles files via drag and drop 
    -- will chown and chmod the parent folder
    -- uses chflags recursively
     � 	 	� 
     S t u b b o r n   f i l e   r e m o v e r 
     b y   P a u l   S c h r e i b e r 
     h t t p : / / p a u l s c h r e i b e r . c o m / 
     w e b @ p a u l s c h r e i b e r . c o m 
     
     r e q u i r e s   M a c   O S   X .   t e s t e d   o n   1 0 . 2 . 1 ,   b u t   s h o u l d   w o r k   o n   e a r l i e r   v e r s i o n s . 
     
     2   N o v e m b e r   2 0 0 2   - -   1 . 0 
       - -   i n i t i a l   r e l e a s e 
       
     9   N o v e m b e r   2 0 0 2   - -   1 . 1 
         - -   n o w   h a n d l e s   f i l e s   v i a   d r a g   a n d   d r o p   
         - -   w i l l   c h o w n   a n d   c h m o d   t h e   p a r e n t   f o l d e r 
         - -   u s e s   c h f l a g s   r e c u r s i v e l y 
   
  
 l     ��������  ��  ��        j     �� �� 0 newline    I    �� ��
�� .sysontocTEXT       shor  m     ���� 
��        j    	�� �� 0 tmpfile    m       �    / t m p / s f r 0 0 0 0 0 0      j   
 �� �� 0 rmbin rmBin  m   
    �    / b i n / r m      l     ��������  ��  ��        j    �� �� 0 ownerbin ownerBin  m       �      / u s r / s b i n / c h o w n   ! " ! j    �� #�� 0 idbin idBin # m     $ $ � % %  / u s r / b i n / i d "  & ' & l     ��������  ��  ��   '  ( ) ( j    �� *�� 0 permsbin permsBin * m     + + � , ,  / b i n / c h m o d )  - . - j    �� /�� 0 permsparams permsParams / m     0 0 � 1 1  - R   u + r w x .  2 3 2 l     ��������  ��  ��   3  4 5 4 j    �� 6�� 0 flagsbin flagsBin 6 m     7 7 � 8 8   / u s r / b i n / c h f l a g s 5  9 : 9 j     �� ;�� 0 flagsparams flagsParams ; m     < < � = =  - R   n o u c h g :  > ? > l     ��������  ��  ��   ?  @ A @ i   ! $ B C B I     ������
�� .aevtoappnull  �   � ****��  ��   C k     T D D  E F E I    �� G H
�� .sysodlogaskr        TEXT G l 	    I���� I m      J J � K K b A r e   y o u   h a v i n g   t r o u b l e   d e l e t i n g   a   f i l e   o r   f o l d e r ?��  ��   H �� L M
�� 
btns L l 
   N���� N J     O O  P Q P m     R R � S S  C a n c e l Q  T U T m     V V � W W  F i l e U  X�� X m     Y Y � Z Z  F o l d e r��  ��  ��   M �� [ \
�� 
dflt [ m    	 ] ] � ^ ^  F o l d e r \ �� _��
�� 
disp _ m   
 ���� ��   F  ` a ` l   ��������  ��  ��   a  b c b Z    9 d e f�� d =    g h g n     i j i 1    ��
�� 
bhit j 1    ��
�� 
rslt h m     k k � l l  F i l e e I   ���� m
�� .sysostdfalis    ��� null��   m �� n��
�� 
prmp n m     o o � p p D S e l e c t   t h e   f i l e   y o u   c a n n o t   d e l e t e :��   f  q r q =  " ) s t s n   " % u v u 1   # %��
�� 
bhit v 1   " #��
�� 
rslt t m   % ( w w � x x  F o l d e r r  y�� y I  , 5���� z
�� .sysostflalis    ��� null��   z �� {��
�� 
prmp { m   . 1 | | � } } H S e l e c t   t h e   f o l d e r   y o u   c a n n o t   d e l e t e :��  ��  ��   c  ~  ~ r   : ? � � � 1   : ;��
�� 
rslt � o      ����  0 thetargetalias theTargetAlias   � � � l  @ @��������  ��  ��   �  � � � I   @ E�������� 0 preptemp prepTemp��  ��   �  � � � I   F N�� ����� 0 fixitem fixItem �  ��� � o   G J����  0 thetargetalias theTargetAlias��  ��   �  ��� � I   O T�������� 0 runtemp runTemp��  ��  ��   A  � � � l     ��������  ��  ��   �  � � � i   % ( � � � I     �� ���
�� .aevtodocnull  �    alis � o      ���� 0 draggeditems  ��   � k     ) � �  � � � I     �������� 0 preptemp prepTemp��  ��   �  � � � X    # ��� � � I    �� ����� 0 fixitem fixItem �  ��� � o    ���� 0 thisitem thisItem��  ��  �� 0 thisitem thisItem � l  	  ����� � c   	  � � � o   	 
���� 0 draggeditems   � m   
 ��
�� 
list��  ��   �  ��� � I   $ )�������� 0 runtemp runTemp��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i   ) , � � � I      �� ����� 0 fixitem fixItem �  ��� � o      ����  0 thetargetalias theTargetAlias��  ��   � Q     � � � � � k    � � �  � � � r     � � � I    �� ����� 0 	getparent 	getParent �  ��� � c     � � � o    ����  0 thetargetalias theTargetAlias � m    ��
�� 
TEXT��  ��   � o      ����  0 theparentalias theParentAlias �  � � � r     � � � n     � � � 1    ��
�� 
psxp � o    ����  0 thetargetalias theTargetAlias � o      ���� 0 thetargetpath theTargetPath �  � � � r     � � � n     � � � 1    ��
�� 
psxp � o    ����  0 theparentalias theParentAlias � o      ���� 0 theparentpath theParentPath �  � � � l   ��������  ��  ��   �  � � � r    ( � � � n    & � � � 4   # &�� �
�� 
cwor � m   $ %����  � l   # ����� � I   #�� ���
�� .sysoexecTEXT���     TEXT � o    ���� 0 idbin idBin��  ��  ��   � o      ���� 0 myuid myUid �  � � � r   ) : � � � b   ) 8 � � � b   ) 4 � � � b   ) 2 � � � b   ) 0 � � � o   ) .�� 0 ownerbin ownerBin � m   . / � � � � �    � o   0 1�~�~ 0 myuid myUid � m   2 3 � � � � �    � n   4 7 � � � 1   5 7�}
�} 
strq � o   4 5�|�| 0 theparentpath theParentPath � o      �{�{ (0 parentownercommand parentOwnerCommand �  � � � r   ; P � � � b   ; N � � � b   ; J � � � b   ; H � � � b   ; B � � � o   ; @�z�z 0 permsbin permsBin � m   @ A � � � � �    � o   B G�y�y 0 permsparams permsParams � m   H I � � � � �    � n   J M � � � 1   K M�x
�x 
strq � o   J K�w�w 0 theparentpath theParentPath � o      �v�v (0 parentpermscommand parentPermsCommand �  � � � r   Q f � � � b   Q d � � � b   Q ` � � � b   Q ^ � � � b   Q X � � � o   Q V�u�u 0 flagsbin flagsBin � m   V W � � � � �    � o   X ]�t�t 0 flagsparams flagsParams � m   ^ _ � � � � �    � n   ` c � � � 1   a c�s
�s 
strq � o   ` a�r�r 0 thetargetpath theTargetPath � o      �q�q 0 flagscommand flagsCommand �    r   g � b   g ~ b   g | b   g v	 b   g t

 b   g n o   g l�p�p 0 newline   o   l m�o�o (0 parentownercommand parentOwnerCommand o   n s�n�n 0 newline  	 o   t u�m�m (0 parentpermscommand parentPermsCommand o   v {�l�l 0 newline   o   | }�k�k 0 flagscommand flagsCommand o      �j�j "0 commandsequence commandSequence  I  � ��i�h
�i .sysoexecTEXT���     TEXT b   � � b   � � b   � � m   � � � 
 e c h o   n   � � 1   � ��g
�g 
strq o   � ��f�f "0 commandsequence commandSequence m   � � �    > >   o   � ��e�e 0 tmpfile  �h   �d l  � ��c�b�a�c  �b  �a  �d   � R      �`
�` .ascrerr ****      � **** o      �_�_ 0 errtext errText �^ �]
�^ 
errn  o      �\�\ 0 errnum errNum�]   � Z   � �!"�[#! l  � �$�Z�Y$ =  � �%&% o   � ��X�X 0 errnum errNum& m   � ��W�W���Z  �Y  " l  � �'()' I  � ��V*+
�V .sysodlogaskr        TEXT* m   � �,, �-- 6 Y o u   c a n c e l e d   t h e   o p e r a t i o n .+ �U./
�U 
btns. m   � �00 �11  G o o d b y e/ �T2�S
�T 
dflt2 m   � ��R�R �S  (   User cancelled.   ) �33     U s e r   c a n c e l l e d .�[  # I  � ��Q4�P
�Q .sysodlogaskr        TEXT4 b   � �565 b   � �787 b   � �9:9 b   � �;<; m   � �== �>> 4 S o r r y ,   a n   e r r o r   o c c u r r e d :  < o   � ��O�O 0 errtext errText: m   � �?? �@@    (8 o   � ��N�N 0 errnum errNum6 m   � �AA �BB  )�P   � CDC l     �M�L�K�M  �L  �K  D EFE i   - 0GHG I      �JI�I�J 0 	getparent 	getParentI J�HJ o      �G�G 0 thepath thePath�H  �I  H k     @KK LML r     NON m     PP �QQ  :O n     RSR 1    �F
�F 
txdlS 1    �E
�E 
ascrM T�DT Z    @UV�CWU l   	X�B�AX E    	YZY o    �@�@ 0 thepath thePathZ m    [[ �\\  :�B  �A  V k    ;]] ^_^ Z    2`a�?b` =   cdc l   e�>�=e n    fgf 4   �<h
�< 
cha h m    �;�;��g o    �:�: 0 thepath thePath�>  �=  d m    ii �jj  :a r    "klk l    m�9�8m n     non 7    �7pq
�7 
citmp m    �6�6 q m    �5�5��o o    �4�4 0 thepath thePath�9  �8  l o      �3�3 0 
folderpath 
folderPath�?  b r   % 2rsr l  % 0t�2�1t n   % 0uvu 7  & 0�0wx
�0 
citmw m   * ,�/�/ x m   - /�.�.��v o   % &�-�- 0 thepath thePath�2  �1  s o      �,�, 0 
folderpath 
folderPath_ yzy l  3 3�+�*�)�+  �*  �)  z {�({ L   3 ;|| c   3 :}~} l  3 8�'�& b   3 8��� l  3 6��%�$� c   3 6��� o   3 4�#�# 0 
folderpath 
folderPath� m   4 5�"
�" 
TEXT�%  �$  � m   6 7�� ���  :�'  �&  ~ m   8 9�!
�! 
alis�(  �C  W L   > @�� o   > ?� �  0 thepath thePath�D  F ��� l     ����  �  �  � ��� i   1 4��� I      ���� 0 preptemp prepTemp�  �  � k     �� ��� I    ���
� .sysoexecTEXT���     TEXT� b     ��� m     �� ���  e c h o   ' '   >  � o    �� 0 tmpfile  �  � ��� I   ���
� .sysoexecTEXT���     TEXT� b    ��� b    ��� o    �� 0 permsbin permsBin� m    �� ���    + x  � o    �� 0 tmpfile  �  �  � ��� l     ����  �  �  � ��� i   5 8��� I      ���� 0 runtemp runTemp�  �  � k     �� ��� I    �
��
�
 .sysoexecTEXT���     TEXT� o     �	�	 0 tmpfile  � ���
� 
badm� m    �
� boovtrue�  � ��� l   ����  � + %do shell script rmBin & " " & tmpfile   � ��� J d o   s h e l l   s c r i p t   r m B i n   &   "   "   &   t m p f i l e�  �       ���    $ + 0 7 <�������  � ��� ������������������������� 0 newline  � 0 tmpfile  �  0 rmbin rmBin�� 0 ownerbin ownerBin�� 0 idbin idBin�� 0 permsbin permsBin�� 0 permsparams permsParams�� 0 flagsbin flagsBin�� 0 flagsparams flagsParams
�� .aevtoappnull  �   � ****
�� .aevtodocnull  �    alis�� 0 fixitem fixItem�� 0 	getparent 	getParent�� 0 preptemp prepTemp�� 0 runtemp runTemp� ���  
� �� C��������
�� .aevtoappnull  �   � ****��  ��  �  �  J�� R V Y�� ]���������� k�� o�� w |����������
�� 
btns
�� 
dflt
�� 
disp�� 
�� .sysodlogaskr        TEXT
�� 
rslt
�� 
bhit
�� 
prmp
�� .sysostdfalis    ��� null
�� .sysostflalis    ��� null��  0 thetargetalias theTargetAlias�� 0 preptemp prepTemp�� 0 fixitem fixItem�� 0 runtemp runTemp�� U�����mv���l� 	O��,�  *��l Y ��,a   *�a l Y hO�E` O*j+ O*_ k+ O*j+ � �� ���������
�� .aevtodocnull  �    alis�� 0 draggeditems  ��  � ������ 0 draggeditems  �� 0 thisitem thisItem� ���������������� 0 preptemp prepTemp
�� 
list
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 fixitem fixItem�� 0 runtemp runTemp�� **j+  O ��&[��l kh *�k+ [OY��O*j+ � �� ����������� 0 fixitem fixItem�� ����� �  ����  0 thetargetalias theTargetAlias��  � ������������������������  0 thetargetalias theTargetAlias��  0 theparentalias theParentAlias�� 0 thetargetpath theTargetPath�� 0 theparentpath theParentPath�� 0 myuid myUid�� (0 parentownercommand parentOwnerCommand�� (0 parentpermscommand parentPermsCommand�� 0 flagscommand flagsCommand�� "0 commandsequence commandSequence�� 0 errtext errText�� 0 errnum errNum� ���������� � ��� � � � ������,��0������=?A
�� 
TEXT�� 0 	getparent 	getParent
�� 
psxp
�� .sysoexecTEXT���     TEXT
�� 
cwor
�� 
strq�� 0 errtext errText� ������
�� 
errn�� 0 errnum errNum��  ����
�� 
btns
�� 
dflt�� 
�� .sysodlogaskr        TEXT�� � �*��&k+ E�O��,E�O��,E�Ob  j �m/E�Ob  �%�%�%��,%E�Ob  �%b  %�%��,%E�Ob  �%b  %�%��,%E�Ob   �%b   %�%b   %�%E�O��,%�%b  %j OPW 8X  �a   a a a a ka  Y a �%a %�%a %j � ��H���������� 0 	getparent 	getParent�� ����� �  ���� 0 thepath thePath��  � ������ 0 thepath thePath�� 0 
folderpath 
folderPath� P����[��i�����������
�� 
ascr
�� 
txdl
�� 
cha 
�� 
citm��������
�� 
TEXT
�� 
alis�� A���,FO�� 4��i/�  �[�\[Zk\Z�2E�Y �[�\[Zk\Z�2E�O��&�%�&Y �� ������������� 0 preptemp prepTemp��  ��  �  � ����
�� .sysoexecTEXT���     TEXT�� �b  %j Ob  �%b  %j � ������������� 0 runtemp runTemp��  ��  �  � ����
�� 
badm
�� .sysoexecTEXT���     TEXT�� b  �el OPascr  ��ޭ