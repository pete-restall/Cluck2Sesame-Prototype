	radix decimal

SunriseSunset code
	global sunriseLookup
	global sunsetLookup

sunriseLookup:
	.dw 0x0828, 0x01e4
	.dw 0x0726, 0x3ee6
	.dw 0x0724, 0x39e8
	.dw 0x071f, 0x33e9
	.dw 0x071c, 0x2aeb
	.dw 0x0719, 0x20ed
	.dw 0x0716, 0x14f0
	.dw 0x0712, 0x08f2
	.dw 0x060f, 0x3bf4
	.dw 0x060c, 0x2df6
	.dw 0x0609, 0x1ef9
	.dw 0x0606, 0x0ffc
	.dw 0x0603, 0x00fe
	.dw 0x0500, 0x3100
	.dw 0x05fd, 0x2202
	.dw 0x05fb, 0x1205
	.dw 0x05f8, 0x0307
	.dw 0x04f5, 0x3409
	.dw 0x04f2, 0x260b
	.dw 0x04ef, 0x180e
	.dw 0x04eb, 0x0b10
	.dw 0x03e8, 0x3f11
	.dw 0x03e5, 0x3314
	.dw 0x03e2, 0x2916
	.dw 0x03de, 0x2118
	.dw 0x03db, 0x1a19
	.dw 0x03da, 0x141b
	.dw 0x03d8, 0x111c
	.dw 0x03d7, 0x101d
	.dw 0x03d7, 0x111d
	.dw 0x03d7, 0x151c
	.dw 0x03d9, 0x1a1b
	.dw 0x03db, 0x2119
	.dw 0x03de, 0x2918
	.dw 0x03e1, 0x3216
	.dw 0x03e4, 0x3c14
	.dw 0x04e8, 0x0612
	.dw 0x04eb, 0x1110
	.dw 0x04ee, 0x1c0e
	.dw 0x04f1, 0x270c
	.dw 0x04f4, 0x3209
	.dw 0x04f7, 0x3d07
	.dw 0x05fa, 0x0805
	.dw 0x05fd, 0x1303
	.dw 0x05ff, 0x1f00
	.dw 0x0502, 0x2afe
	.dw 0x0506, 0x35fc
	.dw 0x0608, 0x01fa
	.dw 0x060b, 0x0df7
	.dw 0x060e, 0x19f5
	.dw 0x0612, 0x25f3
	.dw 0x0614, 0x32f0
	.dw 0x0618, 0x3eee
	.dw 0x071c, 0x0aec
	.dw 0x071f, 0x16ea
	.dw 0x0722, 0x21e8
	.dw 0x0725, 0x2be6
	.dw 0x0727, 0x34e5
	.dw 0x0729, 0x3be3
	.dw 0x072a, 0x3fe3
	.dw 0x0829, 0x01e4

sunsetLookup:
	.dw 0x0ed7, 0x271b
	.dw 0x0eda, 0x2f1a
	.dw 0x0edd, 0x3819
	.dw 0x0fe1, 0x0317
	.dw 0x0fe4, 0x0f15
	.dw 0x0fe7, 0x1c12
	.dw 0x0fea, 0x2910
	.dw 0x0fee, 0x350e
	.dw 0x10f1, 0x020c
	.dw 0x10f4, 0x0f09
	.dw 0x10f7, 0x1b07
	.dw 0x10fb, 0x2705
	.dw 0x10fe, 0x3303
	.dw 0x1000, 0x3f00
	.dw 0x1103, 0x0bfe
	.dw 0x1105, 0x17fb
	.dw 0x1109, 0x22fa
	.dw 0x110c, 0x2ef7
	.dw 0x110f, 0x39f5
	.dw 0x1212, 0x05f2
	.dw 0x1215, 0x10f1
	.dw 0x1218, 0x1cee
	.dw 0x121c, 0x26ec
	.dw 0x121e, 0x31e9
	.dw 0x1222, 0x3ae8
	.dw 0x1325, 0x02e7
	.dw 0x1327, 0x09e5
	.dw 0x1328, 0x0fe4
	.dw 0x132a, 0x12e3
	.dw 0x132a, 0x13e4
	.dw 0x1329, 0x12e4
	.dw 0x1327, 0x0fe5
	.dw 0x1324, 0x0ae6
	.dw 0x1321, 0x03e8
	.dw 0x121e, 0x3aea
	.dw 0x121b, 0x30ec
	.dw 0x1218, 0x25ee
	.dw 0x1215, 0x18f0
	.dw 0x1212, 0x0bf2
	.dw 0x110f, 0x3df5
	.dw 0x110c, 0x2ef8
	.dw 0x1108, 0x20f9
	.dw 0x1106, 0x10fc
	.dw 0x1103, 0x01fe
	.dw 0x1000, 0x3200
	.dw 0x10fe, 0x2202
	.dw 0x10fb, 0x1304
	.dw 0x10f8, 0x0407
	.dw 0x0ff5, 0x3509
	.dw 0x0ff2, 0x270b
	.dw 0x0fef, 0x190e
	.dw 0x0feb, 0x0d0f
	.dw 0x0fe8, 0x0112
	.dw 0x0ee5, 0x3614
	.dw 0x0ee1, 0x2d16
	.dw 0x0ede, 0x2519
	.dw 0x0edb, 0x201a
	.dw 0x0ed9, 0x1c1c
	.dw 0x0ed6, 0x1c1c
	.dw 0x0ed6, 0x1d1d
	.dw 0x0ed7, 0x211c

	end
