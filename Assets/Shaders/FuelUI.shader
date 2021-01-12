// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FuelUI"
{
	Properties
	{
		_ScrollSpeed("ScrollSpeed", Float) = 0.5
		_Texture0("Texture 0", 2D) = "white" {}
		_InnerBubblesColor("InnerBubblesColor", Color) = (1,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Texture2("Texture 2", 2D) = "black" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_FloodColor("FloodColor", Color) = (0,0,0,0)
		_GradientIntensity("GradientIntensity", Float) = 0.46
		_EnergyFill("EnergyFill", Range( 0 , 1)) = 0
		_GasGradiente("GasGradiente", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _GasGradiente;
		uniform float4 _GasGradiente_ST;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float4 _FloodColor;
		uniform sampler2D _Texture2;
		uniform float _ScrollSpeed;
		uniform float _EnergyFill;
		uniform float4 _InnerBubblesColor;
		uniform sampler2D _Texture1;
		uniform float _GradientIntensity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode73 = tex2D( _TextureSample0, uv_TextureSample0 );
			float2 uv_GasGradiente = i.uv_texcoord * _GasGradiente_ST.xy + _GasGradiente_ST.zw;
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode15 = tex2D( _Texture0, uv_Texture0 );
			float TankMask93 = tex2DNode15.g;
			float4 temp_cast_0 = (( (0.17 + (tex2D( _GasGradiente, uv_GasGradiente ).r - 0.63) * (1.0 - 0.17) / (0.79 - 0.63)) * TankMask93 )).xxxx;
			float mulTime42 = _Time.y * 0.25;
			float2 appendResult58 = (float2(_ScrollSpeed , 0.0));
			float2 temp_cast_1 = ((0.03 + (( 1.0 - _EnergyFill ) - 0.0) * (0.6 - 0.03) / (1.0 - 0.0))).xx;
			float2 uv_TexCoord49 = i.uv_texcoord + temp_cast_1;
			float2 panner57 = ( mulTime42 * appendResult58 + uv_TexCoord49);
			float4 tex2DNode48 = tex2D( _Texture2, panner57 );
			float4 lerpResult40 = lerp( tex2DNode73 , ( _FloodColor * ( TankMask93 * tex2DNode48.r ) ) , ( tex2DNode15.g * tex2DNode48.a ));
			float temp_output_86_0 = ( tex2DNode15.g * tex2DNode48.g );
			float2 appendResult13 = (float2(0.0 , _ScrollSpeed));
			float2 appendResult72 = (float2(0.0 , 0.0));
			float2 uv_TexCoord20 = i.uv_texcoord + appendResult72;
			float2 panner12 = ( mulTime42 * appendResult13 + uv_TexCoord20);
			float4 tex2DNode39 = tex2D( _Texture1, panner12 );
			float4 lerpResult70 = lerp( lerpResult40 , ( temp_output_86_0 * ( _InnerBubblesColor * tex2DNode39.r ) ) , ( temp_output_86_0 * tex2DNode39.a ));
			float4 blendOpSrc100 = temp_cast_0;
			float4 blendOpDest100 = lerpResult70;
			float4 lerpBlendMode100 = lerp(blendOpDest100,( blendOpSrc100 * blendOpDest100 ),_GradientIntensity);
			float4 lerpResult102 = lerp( tex2DNode73 , ( saturate( lerpBlendMode100 )) , TankMask93);
			o.Emission = lerpResult102.rgb;
			o.Alpha = tex2DNode15.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18711
288;207;1390;745;2918.676;190.1498;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;105;-2372.599,314.5969;Inherit;False;Property;_EnergyFill;EnergyFill;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;108;-2092.775,231.6666;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2090.056,509.9002;Inherit;False;Property;_ScrollSpeed;ScrollSpeed;0;0;Create;True;0;0;0;False;0;False;0.5;-0.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;106;-1931.561,256.899;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.03;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;-1637.266,368.8443;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1700.883,181.1435;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;42;-1625.868,662.6226;Inherit;False;1;0;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;44;-1203.967,-591.6243;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;0;False;0;False;None;3d763f65bd35a174ab73f54d9f55eb82;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DynamicAppendNode;72;-1594.33,831.788;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;78;-1378.981,-210.7519;Inherit;True;Property;_Texture2;Texture 2;4;0;Create;True;0;0;0;False;0;False;None;33b5a002c2580f541876236702c0daaa;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;57;-1395.213,180.1626;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;15;-907.0858,-591.6393;Inherit;True;Property;_MainInterface;MainInterface;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1621.406,492.0977;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1279.884,666.059;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;-522.262,-715.5664;Inherit;False;TankMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;12;-1016.88,460.5778;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;48;-976.8757,-219.0586;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;81;-768.8622,967.5983;Inherit;True;Property;_Texture1;Texture 1;5;0;Create;True;0;0;0;False;0;False;None;6590226ab6deb444cba5b34e9670d2b8;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-313.4565,-535.2693;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;85;-303.74,-827.4879;Inherit;False;Property;_FloodColor;FloodColor;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.2186197,0.6415094,0.1361695,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;39;-517.2875,561.8157;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;94aba7dce416c7040b51d1688d29a3c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;-378.5032,908.2868;Inherit;False;Property;_InnerBubblesColor;InnerBubblesColor;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;0.2852656,0.6320754,0.2176486,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;125;386.6608,-1356.805;Inherit;True;Property;_GasGradiente;GasGradiente;9;0;Create;True;0;0;0;False;0;False;-1;979cc9569f3401c49b6bae27e99d885e;979cc9569f3401c49b6bae27e99d885e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-62.68628,-271.9865;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-409.8201,-15.66117;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;73;67.83659,-947.1081;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;94aba7dce416c7040b51d1688d29a3c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;87.89137,-613.3016;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-47.60728,639.4821;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;40;642.8597,-553.7238;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;104;749.3967,-1329.687;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0.63;False;2;FLOAT;0.79;False;3;FLOAT;0.17;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-49.84293,288.5958;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;294.59,296.0815;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;683.2189,-996.7076;Inherit;True;93;TankMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;1136.639,-798.548;Inherit;False;Property;_GradientIntensity;GradientIntensity;7;0;Create;True;0;0;0;False;0;False;0.46;0.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;70;1134.677,-561.1673;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;1016.274,-1044.581;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;67;429.5507,224.0802;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;100;1392.655,-888.3915;Inherit;True;Multiply;True;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.78;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;1324.45,-292.0628;Inherit;False;93;TankMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;112;1750.757,216.3383;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;102;1675.487,-529.5192;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;30;1967.1,-574.1987;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;FuelUI;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;108;0;105;0
WireConnection;106;0;108;0
WireConnection;58;0;11;0
WireConnection;49;1;106;0
WireConnection;57;0;49;0
WireConnection;57;2;58;0
WireConnection;57;1;42;0
WireConnection;15;0;44;0
WireConnection;13;1;11;0
WireConnection;20;1;72;0
WireConnection;93;0;15;2
WireConnection;12;0;20;0
WireConnection;12;2;13;0
WireConnection;12;1;42;0
WireConnection;48;0;78;0
WireConnection;48;1;57;0
WireConnection;62;0;93;0
WireConnection;62;1;48;1
WireConnection;39;0;81;0
WireConnection;39;1;12;0
WireConnection;76;0;15;2
WireConnection;76;1;48;4
WireConnection;86;0;15;2
WireConnection;86;1;48;2
WireConnection;84;0;85;0
WireConnection;84;1;62;0
WireConnection;82;0;71;0
WireConnection;82;1;39;1
WireConnection;40;0;73;0
WireConnection;40;1;84;0
WireConnection;40;2;76;0
WireConnection;104;0;125;1
WireConnection;69;0;86;0
WireConnection;69;1;39;4
WireConnection;88;0;86;0
WireConnection;88;1;82;0
WireConnection;70;0;40;0
WireConnection;70;1;88;0
WireConnection;70;2;69;0
WireConnection;92;0;104;0
WireConnection;92;1;94;0
WireConnection;67;0;15;4
WireConnection;100;0;92;0
WireConnection;100;1;70;0
WireConnection;100;2;101;0
WireConnection;112;0;67;0
WireConnection;102;0;73;0
WireConnection;102;1;100;0
WireConnection;102;2;103;0
WireConnection;30;2;102;0
WireConnection;30;9;112;0
ASEEND*/
//CHKSM=A59874C8165224CAC3F006BAB810770C092DE472