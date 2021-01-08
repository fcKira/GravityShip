// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FuelUI"
{
	Properties
	{
		_ScrollSpeed("ScrollSpeed", Float) = 0.5
		_Texture0("Texture 0", 2D) = "white" {}
		_FloodOffset("FloodOffset", Float) = 0
		_InnerBubblesColor("InnerBubblesColor", Color) = (1,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Texture2("Texture 2", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_FloodColor("FloodColor", Color) = (0,0,0,0)
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
		uniform float4 _FloodColor;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform sampler2D _Texture2;
		uniform float _ScrollSpeed;
		uniform float _FloodOffset;
		uniform sampler2D _Texture1;
		uniform float4 _InnerBubblesColor;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode15 = tex2D( _Texture0, uv_Texture0 );
			float mulTime42 = _Time.y * 0.25;
			float2 appendResult58 = (float2(_ScrollSpeed , 0.0));
			float2 temp_cast_0 = (_FloodOffset).xx;
			float2 uv_TexCoord49 = i.uv_texcoord + temp_cast_0;
			float2 panner57 = ( mulTime42 * appendResult58 + uv_TexCoord49);
			float4 tex2DNode48 = tex2D( _Texture2, panner57 );
			float4 lerpResult40 = lerp( tex2D( _TextureSample0, uv_TextureSample0 ) , ( ( _FloodColor * ( tex2DNode15.g * tex2DNode48.a ) ) * tex2DNode48.g ) , ( tex2DNode15.g * tex2DNode48.a ));
			float temp_output_86_0 = ( tex2DNode15.g * tex2DNode48.r );
			float2 appendResult13 = (float2(0.0 , _ScrollSpeed));
			float2 appendResult72 = (float2(0.0 , _FloodOffset));
			float2 uv_TexCoord20 = i.uv_texcoord + appendResult72;
			float2 panner12 = ( mulTime42 * appendResult13 + uv_TexCoord20);
			float4 tex2DNode39 = tex2D( _Texture1, panner12 );
			float temp_output_69_0 = ( temp_output_86_0 * tex2DNode39.a );
			float4 lerpResult70 = lerp( ( lerpResult40 + temp_output_69_0 ) , ( temp_output_86_0 * ( _InnerBubblesColor * tex2DNode39.r ) ) , temp_output_69_0);
			o.Emission = saturate( lerpResult70 ).rgb;
			o.Alpha = tex2DNode15.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18711
0;73;786;655;307.8679;1389.997;3.192932;False;False
Node;AmplifyShaderEditor.RangedFloatNode;50;-1915.452,281.1559;Inherit;False;Property;_FloodOffset;FloodOffset;2;0;Create;True;0;0;0;False;0;False;0;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2090.056,509.9002;Inherit;False;Property;_ScrollSpeed;ScrollSpeed;0;0;Create;True;0;0;0;False;0;False;0.5;-0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;-1637.266,368.8443;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1700.883,181.1435;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;42;-1625.868,662.6226;Inherit;False;1;0;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;44;-1203.967,-591.6243;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;0;False;0;False;None;3d763f65bd35a174ab73f54d9f55eb82;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;78;-1378.981,-205.9519;Inherit;True;Property;_Texture2;Texture 2;5;0;Create;True;0;0;0;False;0;False;None;3e24d74986dfe9945a1f52c44e944bcd;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;57;-1395.213,180.1626;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;72;-1594.33,831.788;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;15;-907.0858,-591.6393;Inherit;True;Property;_MainInterface;MainInterface;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;-924.8707,-215.2547;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-378.4562,-494.9693;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;85;-262.263,-791.421;Inherit;False;Property;_FloodColor;FloodColor;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.08235293,0.6117647,0.4193995,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1279.884,666.059;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1621.406,492.0977;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-0.4728854,-630.5317;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;12;-1016.88,460.5778;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;81;-768.8622,967.5983;Inherit;True;Property;_Texture1;Texture 1;6;0;Create;True;0;0;0;False;0;False;None;6590226ab6deb444cba5b34e9670d2b8;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;119.2409,-130.319;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-439.0172,256.409;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;232.6087,-378.9667;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;39;-517.2875,561.8157;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;94aba7dce416c7040b51d1688d29a3c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;73;67.83659,-947.1081;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;None;94aba7dce416c7040b51d1688d29a3c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;-378.5032,908.2868;Inherit;False;Property;_InnerBubblesColor;InnerBubblesColor;3;0;Create;True;0;0;0;False;0;False;1,0,0,0;0.1254902,0.6235294,0.3105595,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-47.60728,639.4821;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;40;482.2109,-414.8692;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-78.81139,267.5277;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;243.7102,500.7194;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;813.4305,-563.1236;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;70;1218.142,-577.7125;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;67;429.5507,224.0802;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;87;1505.55,-572.755;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;30;1820.327,-612.5035;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;FuelUI;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;58;0;11;0
WireConnection;49;1;50;0
WireConnection;57;0;49;0
WireConnection;57;2;58;0
WireConnection;57;1;42;0
WireConnection;72;1;50;0
WireConnection;15;0;44;0
WireConnection;48;0;78;0
WireConnection;48;1;57;0
WireConnection;62;0;15;2
WireConnection;62;1;48;4
WireConnection;20;1;72;0
WireConnection;13;1;11;0
WireConnection;84;0;85;0
WireConnection;84;1;62;0
WireConnection;12;0;20;0
WireConnection;12;2;13;0
WireConnection;12;1;42;0
WireConnection;76;0;15;2
WireConnection;76;1;48;4
WireConnection;86;0;15;2
WireConnection;86;1;48;1
WireConnection;89;0;84;0
WireConnection;89;1;48;2
WireConnection;39;0;81;0
WireConnection;39;1;12;0
WireConnection;82;0;71;0
WireConnection;82;1;39;1
WireConnection;40;0;73;0
WireConnection;40;1;89;0
WireConnection;40;2;76;0
WireConnection;69;0;86;0
WireConnection;69;1;39;4
WireConnection;88;0;86;0
WireConnection;88;1;82;0
WireConnection;66;0;40;0
WireConnection;66;1;69;0
WireConnection;70;0;66;0
WireConnection;70;1;88;0
WireConnection;70;2;69;0
WireConnection;67;0;15;4
WireConnection;87;0;70;0
WireConnection;30;2;87;0
WireConnection;30;9;67;0
ASEEND*/
//CHKSM=12340BC6457FF3E95D2CBF084479F5E47066AEED