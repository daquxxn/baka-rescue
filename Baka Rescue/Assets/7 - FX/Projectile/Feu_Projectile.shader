// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Feu_projectile"
{
	Properties
	{
		_Bias1("Bias", Range( 0 , 1)) = 0.215048
		_Scale1("Scale", Range( 0 , 5)) = 1.479272
		_Power1("Power", Range( 0 , 5)) = 2.126081
		_Color1("Color 0", Color) = (1,0.8873018,0,0)
		_Color2("Color 1", Color) = (1,0.09377968,0,0)
		_Mask1("Mask", Range( 0 , 5)) = 1.039313
		_1("0", Range( 0 , 5)) = 1.039313
		_Height1("Height", Range( 0 , 1)) = 0
		_Wave1("Wave", 2D) = "white" {}
		_Noise1("Noise", 2D) = "white" {}
		_U1("U", Range( -5 , 5)) = 0.2591188
		_V1("V", Range( -5 , 5)) = 0.3641046
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform sampler2D _Wave1;
		uniform float _U1;
		uniform float _V1;
		uniform sampler2D _Noise1;
		uniform float _Mask1;
		uniform float _1;
		uniform float _Height1;
		uniform float4 _Color1;
		uniform float4 _Color2;
		uniform float _Bias1;
		uniform float _Scale1;
		uniform float _Power1;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 transform14 = mul(unity_WorldToObject,float4( float3(0,1,0) , 0.0 ));
			float4 appendResult6 = (float4(_U1 , _V1 , 0.0 , 0.0));
			float2 panner7 = ( 0.5 * _Time.y * appendResult6.xy + v.texcoord.xy);
			float4 temp_output_15_0 = ( tex2Dlod( _Wave1, float4( panner7, 0, 0.0) ) * tex2Dlod( _Noise1, float4( panner7, 0, 0.0) ) );
			float4 lerpResult18 = lerp( float4( 0,0,0,0 ) , transform14 , temp_output_15_0);
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float clampResult16 = clamp( ( distance( ase_worldNormal.y , _Mask1 ) - _1 ) , 0.0 , 1.0 );
			float temp_output_19_0 = ( 1.0 - clampResult16 );
			float4 lerpResult26 = lerp( float4( 0,0,0,0 ) , lerpResult18 , temp_output_19_0);
			v.vertex.xyz += ( lerpResult26 * _Height1 ).xyz;
			float3 ase_vertexNormal = v.normal.xyz;
			v.normal = ase_vertexNormal;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV23 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode23 = ( _Bias1 + _Scale1 * pow( 1.0 - fresnelNdotV23, _Power1 ) );
			float4 lerpResult29 = lerp( _Color1 , _Color2 , fresnelNode23);
			o.Emission = lerpResult29.rgb;
			float clampResult16 = clamp( ( distance( ase_worldNormal.y , _Mask1 ) - _1 ) , 0.0 , 1.0 );
			float temp_output_19_0 = ( 1.0 - clampResult16 );
			float4 appendResult6 = (float4(_U1 , _V1 , 0.0 , 0.0));
			float2 panner7 = ( 0.5 * _Time.y * appendResult6.xy + i.uv_texcoord);
			float4 temp_output_15_0 = ( tex2D( _Wave1, panner7 ) * tex2D( _Noise1, panner7 ) );
			o.Alpha = ( fresnelNode23 * temp_output_19_0 * temp_output_15_0 ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
58;78;1434;611;3163.073;-795.1415;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-3175.124,742.2844;Inherit;False;Property;_V1;V;11;0;Create;True;0;0;False;0;0.3641046;0;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-3174.248,650.1851;Inherit;False;Property;_U1;U;10;0;Create;True;0;0;False;0;0.2591188;0;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-2852.647,532.2498;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-2579.576,1190.022;Inherit;True;Property;_Mask1;Mask;5;0;Create;True;0;0;False;0;1.039313;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-2825.068,659.5431;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldNormalVector;4;-2619.946,949.8301;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;7;-2536.917,566.6178;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2250.523,1311.547;Inherit;True;Property;_1;0;6;0;Create;True;0;0;False;0;1.039313;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;9;-2201.913,1019.885;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-2197.557,549.7175;Inherit;True;Property;_Wave1;Wave;8;0;Create;True;0;0;False;0;9789d23040cb1fb45ad60392430c3c15;9789d23040cb1fb45ad60392430c3c15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-2196.827,750.4827;Inherit;True;Property;_Noise1;Noise;9;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;12;-2145.84,375.1914;Inherit;False;Constant;_Vector1;Vector 0;7;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-1923.338,1038.582;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;16;-1670.936,1018.016;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;14;-1862.213,358.8565;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1835.428,554.232;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1957.638,42.6664;Inherit;False;Property;_Bias1;Bias;0;0;Create;True;0;0;False;0;0.215048;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;19;-1513.887,945.1;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1983.521,135.3136;Inherit;False;Property;_Scale1;Scale;1;0;Create;True;0;0;False;0;1.479272;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1972.625,232.048;Inherit;False;Property;_Power1;Power;2;0;Create;True;0;0;False;0;2.126081;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-1425.763,507.99;Inherit;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FresnelNode;23;-1456.253,94.4398;Inherit;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-960.7764,577.3232;Inherit;True;Property;_Height1;Height;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;22;-1371.607,-137.5015;Inherit;False;Property;_Color2;Color 1;4;0;Create;True;0;0;False;0;1,0.09377968,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;-1374.269,-313.1613;Inherit;False;Property;_Color1;Color 0;3;0;Create;True;0;0;False;0;1,0.8873018,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;26;-928.2596,385.2111;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalVertexDataNode;31;-258.1473,573.3242;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-734.1871,126.4578;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2954.484,833.5114;Inherit;False;Property;_Speed1;Speed;12;0;Create;True;0;0;False;0;0.7822366;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;-977.7039,-218.6777;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-594.6508,403.7703;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Feu_projectile;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;2;0
WireConnection;6;1;1;0
WireConnection;7;0;5;0
WireConnection;7;2;6;0
WireConnection;9;0;4;2
WireConnection;9;1;3;0
WireConnection;10;1;7;0
WireConnection;11;1;7;0
WireConnection;13;0;9;0
WireConnection;13;1;8;0
WireConnection;16;0;13;0
WireConnection;14;0;12;0
WireConnection;15;0;10;0
WireConnection;15;1;11;0
WireConnection;19;0;16;0
WireConnection;18;1;14;0
WireConnection;18;2;15;0
WireConnection;23;1;17;0
WireConnection;23;2;20;0
WireConnection;23;3;21;0
WireConnection;26;1;18;0
WireConnection;26;2;19;0
WireConnection;30;0;23;0
WireConnection;30;1;19;0
WireConnection;30;2;15;0
WireConnection;29;0;25;0
WireConnection;29;1;22;0
WireConnection;29;2;23;0
WireConnection;28;0;26;0
WireConnection;28;1;24;0
WireConnection;0;2;29;0
WireConnection;0;9;30;0
WireConnection;0;11;28;0
WireConnection;0;12;31;0
ASEEND*/
//CHKSM=F86A65A8671895B55E8EA2BDEF5A40B5D869A886