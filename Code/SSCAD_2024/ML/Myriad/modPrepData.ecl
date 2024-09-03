IMPORT $;
//
Property := $.modProperty.File;
//
EXPORT modPrepData := MODULE
	EXPORT ML_Prop := RECORD
		UNSIGNED8 propertyid;           // corresponde ao campo "idfield" usado na conversão matricial pelo ML_Core.ToField
		UNSIGNED3 zip; 			            // variável Categórica
		UNSIGNED4 assessed_value;
		UNSIGNED2 year_acquired;
		UNSIGNED4 land_square_footage;
		UNSIGNED4 living_square_feet;
		UNSIGNED2 bedrooms;
		UNSIGNED2 full_baths;
		UNSIGNED2 half_baths;
		UNSIGNED2 year_built;
		UNSIGNED4 total_value; 		      // variável Dependente (a ser determinada)
    UNSIGNED4 wi_id;                // Work-Item ID usado na Interface Myriad
	END;
//
  EXPORT ML_PropExt := RECORD(ML_Prop)
    UNSIGNED4 rnd;                  // número randômico
  END;
//
	EXPORT MyriadPrepData := PROJECT($.CleanProperty, TRANSFORM(ML_PropExt,
                                                      SELF.rnd   := RANDOM(),
                                                      SELF.zip   := (UNSIGNED3)LEFT.zip,
                                                      SELF.wi_id := MAP(LEFT.state = 'AE' =>  1, LEFT.state = 'WY' =>  2,
                                                                        LEFT.state = 'TN' =>  3, LEFT.state = 'MI' =>  4,
                                                                        LEFT.state = 'RI' =>  5, LEFT.state = 'SC' =>  6,
                                                                        LEFT.state = 'VA' =>  7, LEFT.state = 'NH' =>  8,
                                                                        LEFT.state = 'AP' =>  9, LEFT.state = 'NM' => 10,
                                                                        LEFT.state = 'IL' => 11, LEFT.state = 'KS' => 12,
                                                                        LEFT.state = 'ME' => 13, LEFT.state = 'AL' => 14,
                                                                        LEFT.state = 'WA' => 15, LEFT.state = 'NY' => 16,
                                                                        LEFT.state = 'MO' => 17, LEFT.state = 'PA' => 18,
                                                                        LEFT.state = 'HI' => 19, LEFT.state = 'GU' => 20,
                                                                        LEFT.state = 'VT' => 21, LEFT.state = 'CT' => 22,
                                                                        LEFT.state = 'NC' => 23, LEFT.state = 'OR' => 24,
                                                                        LEFT.state = 'IA' => 25, LEFT.state = 'DE' => 26,
                                                                        LEFT.state = 'VI' => 27, LEFT.state = 'ID' => 28,
                                                                        LEFT.state = 'MT' => 29, LEFT.state = 'AR' => 30,
                                                                        LEFT.state = 'MS' => 31, LEFT.state = 'UT' => 32,
                                                                        LEFT.state = 'NE' => 33, LEFT.state = 'IN' => 34,
                                                                        LEFT.state = 'GA' => 35, LEFT.state = 'WV' => 36,
                                                                        LEFT.state = 'NJ' => 37, LEFT.state = 'LA' => 38,
                                                                        LEFT.state = 'WI' => 39, LEFT.state = 'AK' => 40,
                                                                        LEFT.state = 'CA' => 41, LEFT.state = 'NV' => 42,
                                                                        LEFT.state = 'FL' => 43, LEFT.state = 'MA' => 44,
                                                                        LEFT.state = 'CO' => 45, LEFT.state = 'AZ' => 46,
                                                                        LEFT.state = 'SD' => 47, LEFT.state = 'DC' => 48,
                                                                        LEFT.state = 'KY' => 49, LEFT.state = 'MP' => 50,
                                                                        LEFT.state = 'ND' => 51, LEFT.state = 'AS' => 52,
                                                                        LEFT.state = 'TX' => 53, LEFT.state = 'PR' => 54,
                                                                        LEFT.state = 'MD' => 55, LEFT.state = 'OH' => 56,
                                                                        LEFT.state = 'MN' => 57, LEFT.state = 'OK' => 58,
                                                                        LEFT.state = 'AA' => 59, 0),
                                                      SELF       := LEFT))
                            :PERSIST('~CLASS::XYZ::ML::MyriadPrepData');
//
END;
//