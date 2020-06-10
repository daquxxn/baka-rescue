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

    /*private void Update()
    {
        if (_characController.CanMove == false)
        {
            _iCounter += Time.deltaTime;

            if (_iCounter >= _iTime)
            {
                _characController.CanMove = true;
            }
        }
    }*/

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
                   
                    _waterSpheres.SetActive(false);
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
                }
                else if (_element == EElement.NONE)
                {
                    _element = EElement.THUNDER;

                    _waterSphere.SetActive(false);
                    _fireSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(true);
                    
                    _waterSpheres.SetActive(false);

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
