using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ElementalCharacter : AElement
{
    [SerializeField] CharacController _characController = null;
    [SerializeField] private float _iTime = 1.5f;
    [SerializeField] private float _iCounter = 0;

    [SerializeField] private GameObject _waterSphere = null;
    [SerializeField] private GameObject _waterSpheres = null;
   
    [SerializeField] private GameObject _thunderSphere = null;
    [SerializeField] private GameObject _thunderSpheres = null;
    [SerializeField] private GameObject _fireSphere = null;

    [SerializeField] private GameObject _fxEclab = null;

    private bool _isElem = false;
    private float _elemTimeStamp = 0f;
    [SerializeField] private float _elemDuration = 2f;

    private bool _isImune = false;

    public bool IsImune
    {
        get
        {
            return _isImune;
        }
    }

    private void Update()
    {
       if(_isElem)
        {
            _elemTimeStamp += Time.deltaTime;
            if(_elemTimeStamp >= _elemDuration)
            {
                _isElem = false;
                _elemTimeStamp = 0;
                _element = EElement.NONE;

                _waterSphere.SetActive(false);
                _fireSphere.SetActive(false);
                _thunderSpheres.SetActive(false);
                _thunderSphere.SetActive(false);

                _waterSpheres.SetActive(false);

                _isImune = false;
            }
        }
    }

    public override void ElementalReaction(EElement element)
    {
        switch (element)
        {
            case EElement.WATER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when WATER touch FIRE surface
                    _element = EElement.WATER;

                    _waterSphere.SetActive(true);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                    _fxEclab.SetActive(true);

                    _waterSpheres.SetActive(false);
                    _isElem = true;
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when WATER touch THUNDER surface
                    _element = EElement.WATER;

                    _waterSphere.SetActive(true);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                    
                    _waterSpheres.SetActive(false);

                    _characController.Stun();
                    _isElem = true;

                    _fxEclab.SetActive(true);


                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when WATER touch WATER surface
                    _element = EElement.WATER;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                
                    _waterSpheres.SetActive(true);
                    _isElem = true;
                    _fxEclab.SetActive(true);

                    _isImune = true;
                    //DEVIENT IMUNE AU FEU
                }
                else if (_element == EElement.NONE)
                {
                   _element = EElement.WATER;

                    _waterSphere.SetActive(true);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                   
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                    _fxEclab.SetActive(true);
                }
                break;
            case EElement.THUNDER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when THUNDER touch FIRE surface
                    _element = EElement.THUNDER;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(true);
             
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when THUNDER touch THUNDER surface
                    _element = EElement.THUNDER;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(true);
                    _thunderSphere.SetActive(false);
                  
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                    //je suis ralenti ? 

                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when THUNDER touch WATER surface
                    _element = EElement.THUNDER;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                   
                    _waterSpheres.SetActive(false);

                    _characController.Stun();
                    _isElem = true;
                }
                else if (_element == EElement.NONE)
                {
                    _element = EElement.THUNDER;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(true);
                    
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                }
                break;
            case EElement.FIRE:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when FIRE touch FIRE surface
                    _element = EElement.FIRE;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(true);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                  
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                    //brulure = dégat !!
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when FIRE touch THUNDER surface
                    _element = EElement.FIRE;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(true);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                   
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                    //brulure = dégat !!
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when FIRE touch WATER surface
                    _element = EElement.FIRE;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(true);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                   
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                    //brulure = dégat !!
                }
                else if (_element == EElement.NONE)
                {
                    _element = EElement.FIRE;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(true);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                
                    _waterSpheres.SetActive(false);
                    _isElem = true;
                    //brulure = dégat !!
                }
                break;
        }
    }


    private void OnTriggerEnter(Collider collider)
    {
        
        // Check if other is AElement
        AElement other = collider.GetComponent<AElement>();
        if (other != null)
        {
            if (other is ElementalProjectile)
            {
                ElementalProjectile elemProj = other.GetComponent<ElementalProjectile>();
                if (elemProj.InstanceID != gameObject.GetInstanceID())
                {
                    // React with other's element
                    ElementalReaction(other.Element);
                }
            }
            else
            {
                // React with other's element
                ElementalReaction(other.Element);
            }
        }
    }
}
