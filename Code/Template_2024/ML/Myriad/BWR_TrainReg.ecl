IMPORT $;
IMPORT ML_Core;
IMPORT LearningTrees AS LT;
//
// Selecionando o algoritmo
//   Sintaxe: RegressionForest(UNSIGNED numTrees=100, UNSIGNED featuresPerNode=0,
//                             UNSIGNED maxDepth=100, SET OF UNSIGNED nominalFields=[])
// MyriadLearnerR := LT.RegressionForest();          // parâmetros default
// MyriadLearnerR := LT.RegressionForest(,,,[1]);    // zip não é realmente quantitativo, mas qualitativo
MyriadLearnerR := LT.RegressionForest(10,,10,[1]); 
//
//
// Obtendo o modelo composto (composto por 45 modelos = números de estados existentes no dataset)
MyriadModelR := MyriadLearnerR.GetModel($.modSegConvData.MyriadIndTrainDataNF,$.modSegConvData.MyriadDepTrainDataNF);
OUTPUT(MyriadModelR,,'~CLASS::XYZ::ML::MyriadModelR', NAMED('Myriad_Modelo_Treinado'),OVERWRITE);
OUTPUT(COUNT(DEDUP(SORT((MyriadModelR), wi), wi)), NAMED('Numero_de_Modelos'));
//
//
// Testando o modelo
MyriadPredictedDeps := MyriadLearnerR.Predict(MyriadModelR,$.modSegConvData.MyriadIndTestDataNF);
OUTPUT(MyriadPredictedDeps, NAMED('Myriad_Valores_Previstos'));
//
//
// Avaliando o modelo
MyriadAssessmentR := ML_Core.Analysis.Regression.Accuracy(MyriadPredictedDeps,$.modSegConvData.MyriadDepTestDataNF);
OUTPUT(MyriadAssessmentR, NAMED('Myriad_Avaliacao_dos_Modelos'));
OUTPUT(SORT(MyriadAssessmentR, -r2), NAMED('Ordenacao_pela_acuracia_dos_Modelos'));
//
//
/*
01 => 'AE',02 => 'WY',03 => 'TN',04 => 'MI',05 => 'RI',06 => 'SC',07 => 'VA',08 => 'NH',09 => 'AP',10 => 'NM',
11 => 'IL',12 => 'KS',13 => 'ME',14 => 'AL',15 => 'WA',16 => 'NY',17 => 'MO',18 => 'PA',19 => 'HI',20 => 'GU',
21 => 'VT',22 => 'CT',23 => 'NC',24 => 'OR',25 => 'IA',26 => 'DE',27 => 'VI',28 => 'ID',29 => 'MT',30 => 'AR',
31 => 'MS',32 => 'UT',33 => 'NE',34 => 'IN',35 => 'GA',36 => 'WV',37 => 'NJ',38 => 'LA',39 => 'WI',40 => 'AK',
41 => 'CA',42 => 'NV',43 => 'FL',44 => 'MA',45 => 'CO',46 => 'AZ',47 => 'SD',48 => 'DC',49 => 'KY',50 => 'MP',
51 => 'ND',52 => 'AS',53 => 'TX',54 => 'PR',55 => 'MD',56 => 'OH',57 => 'MN',58 => 'OK',59 => 'AA'.
*/
//