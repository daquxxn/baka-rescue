// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Burn02"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Texture0("Texture 0", 2D) = "bump" {}
		_Disparition("Disparition", Range( 0 , 1)) = 0.285832
		_Disparition02("Disparition02", Range( 0 , 1)) = 0.411262
		_Mask_Diparition("Mask_Diparition", Range( 0 , 1)) = 0.4250781
		_Color0("Color 0", Color) = (1,0,0,0)
		_Color1("Color 1", Color) = (1,0.7392709,0,0)
		_Texture1("Texture 1", 2D) = "white" {}
		_Float0("Float 0", Range( 0 , 1)) = 0.6367218
		_Bord_Burn("Bord_Burn", Range( 0 , 1.5)) = 1.5
		_Vitesse("Vitesse", Range( 0 , 1)) = 0.2519046
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform sampler2D _Texture1;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _Disparition;
		uniform float _Vitesse;
		uniform float _Float0;
		uniform float _Disparition02;
		uniform float _Mask_Diparition;
		uniform float _Bord_Burn;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float temp_output_40_0 = ( _Time.y * _Vitesse );
			float2 panner37 = ( temp_output_40_0 * float2( 0,-1 ) + float2( 0,0 ));
			float2 uv_TexCoord36 = i.uv_texcoord + panner37;
			float4 lerpResult29 = lerp( _Color0 , _Color1 , tex2D( _Texture1, ( ( (UnpackScaleNormal( tex2D( _Texture0, uv_Texture0 ), 2.0 )).xy * _Disparition ) + uv_TexCoord36 ) ).r);
			float4 temp_cast_0 = (_Float0).xxxx;
			float2 uv_TexCoord41 = i.uv_texcoord * float2( 2,-2 );
			float2 panner42 = ( temp_output_40_0 * float2( 0,-1 ) + uv_TexCoord41);
			float4 tex2DNode15 = tex2D( _Texture1, ( ( (UnpackScaleNormal( tex2D( _Texture0, panner42 ), 0.5 )).xy * _Disparition02 ) + i.uv_texcoord ) );
			float temp_output_17_0 = step( tex2DNode15.r , _Mask_Diparition );
			float temp_output_23_0 = ( temp_output_17_0 + ( temp_output_17_0 - step( tex2DNode15.r , ( _Mask_Diparition / _Bord_Burn ) ) ) );
			o.Emission = ( ( pow( lerpResult29 , temp_cast_0 ) * _Float0 ) * temp_output_23_0 ).rgb;
			o.Alpha = 1;
			clip( temp_output_23_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
0;0;1920;1019;4171.209;598.1523;1.873686;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;38;-4954.826,-86.84906;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-5032.655,198.9764;Inherit;True;Property;_Vitesse;Vitesse;12;0;Create;True;0;0;False;0;0.2519046;0.09260755;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-4669.875,41.15393;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-4628.465,587.4973;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;2,-2;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;42;-4351.174,623.8093;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;8;-5749.7,-276.9121;Inherit;True;Property;_Texture0;Texture 0;3;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;0bebe40e9ebbecc48b8e9cfea982da7e;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;43;-3974.289,508.0226;Inherit;True;Property;_TextureSample4;Texture Sample 4;2;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.5;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-4702.558,-260.1037;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;2;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-4389.692,-58.09139;Inherit;False;Property;_Disparition;Disparition;4;0;Create;True;0;0;False;0;0.285832;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3737.353,894.6147;Inherit;False;Property;_Disparition02;Disparition02;5;0;Create;True;0;0;False;0;0.411262;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;45;-3636.723,509.1748;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;9;-4377.75,-260.5463;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;37;-4307.231,29.47158;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-4053.049,-26.1851;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-3317.61,478.8239;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-4058.636,-255.6367;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-3314.655,745.4723;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-2589.642,417.8011;Inherit;True;Property;_Bord_Burn;Bord_Burn;11;0;Create;True;0;0;False;0;1.5;1.09;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;16;-2895.684,-495.0184;Inherit;True;Property;_Texture1;Texture 1;9;0;Create;True;0;0;False;0;e4cb3880e06c02e49aa9aedc09c38f21;cd460ee4ac5c1e746b7a734cc7cc64dd;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2501.618,248.4539;Inherit;False;Property;_Mask_Diparition;Mask_Diparition;6;0;Create;True;0;0;False;0;0.4250781;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-3706.321,-258.1895;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-2970.392,343.1837;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-2256.819,-294.8702;Inherit;True;Property;_TextureSample3;Texture Sample 3;4;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;26;-2206.452,-791.3651;Inherit;False;Property;_Color0;Color 0;7;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-2264.063,-79.70099;Inherit;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-2209.644,-607.8711;Inherit;False;Property;_Color1;Color 1;8;0;Create;True;0;0;False;0;1,0.7392709,0,0;1,0.7392709,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;20;-2123.725,308.1604;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1613.09,-823.6855;Inherit;False;Property;_Float0;Float 0;10;0;Create;True;0;0;False;0;0.6367218;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;18;-1826.878,164.5701;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;-1925.162,-808.488;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;17;-1824.22,-61.14664;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1279.975,-1103.959;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-1473.009,3.719023;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-967.543,-931.6591;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-871.0619,-382.7231;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;53;-3071.523,-158.736;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1340.543,-506.1914;Inherit;True;Property;_Alpha01;Alpha01;1;0;Create;True;0;0;False;0;153f0c19c3abd7241b56732f387a2f39;153f0c19c3abd7241b56732f387a2f39;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-2755.427,-154.053;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;55;-467.0185,-938.812;Inherit;True;Property;_TextureSample5;Texture Sample 5;14;0;Create;True;0;0;False;0;7130c16fd8005b546b111d341310a9a4;7130c16fd8005b546b111d341310a9a4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;-3412.962,-50.30745;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;153f0c19c3abd7241b56732f387a2f39;153f0c19c3abd7241b56732f387a2f39;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-3116.499,166.3023;Inherit;False;Property;_Float3;Float 3;13;0;Create;True;0;0;False;0;0.2699268;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClipNode;25;-817.4487,-659.1868;Inherit;False;3;0;FLOAT;0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-434.5457,-609.8418;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-86.50617,-655.3774;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Burn02;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;38;0
WireConnection;40;1;39;0
WireConnection;42;0;41;0
WireConnection;42;1;40;0
WireConnection;43;0;8;0
WireConnection;43;1;42;0
WireConnection;6;0;8;0
WireConnection;45;0;43;0
WireConnection;9;0;6;0
WireConnection;37;1;40;0
WireConnection;36;1;37;0
WireConnection;46;0;45;0
WireConnection;46;1;44;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;35;0;10;0
WireConnection;35;1;36;0
WireConnection;47;0;46;0
WireConnection;47;1;48;0
WireConnection;14;0;16;0
WireConnection;14;1;35;0
WireConnection;15;0;16;0
WireConnection;15;1;47;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;18;0;15;1
WireConnection;18;1;20;0
WireConnection;29;0;26;0
WireConnection;29;1;27;0
WireConnection;29;2;14;1
WireConnection;17;0;15;1
WireConnection;17;1;19;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;22;0;17;0
WireConnection;22;1;18;0
WireConnection;32;0;30;0
WireConnection;32;1;31;0
WireConnection;23;0;17;0
WireConnection;23;1;22;0
WireConnection;52;0;53;0
WireConnection;52;1;49;0
WireConnection;25;0;40;0
WireConnection;25;1;1;1
WireConnection;25;2;23;0
WireConnection;34;0;32;0
WireConnection;34;1;23;0
WireConnection;0;2;34;0
WireConnection;0;10;23;0
ASEEND*/
//CHKSM=36555EAD8EE399529B321C25265AE6B7205F63FE