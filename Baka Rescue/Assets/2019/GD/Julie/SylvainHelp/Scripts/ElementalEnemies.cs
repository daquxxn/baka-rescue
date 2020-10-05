using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ElementalEnemies : AElement
{
    
    [SerializeField] Enemy2 _enemy2 = null;
    [SerializeField] Enemy1 _enemy1 = null;

    [SerializeField] private GameObject _waterSphere = null;
    [SerializeField] private GameObject _waterSpheres = null;

    [SerializeField] private GameObject _thunderSphere = null;
    [SerializeField] private GameObject _thunderSpheres = null;

    [SerializeField] private ParticleSystem _fxEclab = null;
    [SerializeField] private GameObject _stunFX = null;

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
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);
                    _fxEclab.Play();
                }
            else if (_element == EElement.THUNDER)
            {
                // do whatever you want to do when WATER touch THUNDER surface
                _element = EElement.WATER;
                    _enemy2.Stun();
                    _enemy1.Stun();

                    _waterSphere.SetActive(true);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);

                    _waterSpheres.SetActive(false);
                    

                    _fxEclab.Play();

                }
                else if (_element == EElement.WATER)
            {
                  // do whatever you want to do when WATER touch WATER surface
                 _element = EElement.WATER;

                    _waterSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);

                    _waterSpheres.SetActive(true);
                    _fxEclab.Play();
                }
            else if (_element == EElement.NONE)
            {
                _element = EElement.WATER;
                    _waterSphere.SetActive(true);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);

                    _waterSpheres.SetActive(false);
                    _fxEclab.Play();
                }
            break;
        case EElement.THUNDER:
            if (_element == EElement.FIRE)
            {
                    // do whatever you want to do when THUNDER touch FIRE surface
                    _element = EElement.THUNDER;
                    _waterSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(true);

                    _waterSpheres.SetActive(false);

                }
            else if (_element == EElement.THUNDER)
            {
                    // do whatever you want to do when THUNDER touch THUNDER surface
                    //stun + lgts
                    _element = EElement.THUNDER;

                    _waterSphere.SetActive(false);
                    _thunderSpheres.SetActive(true);
                    _thunderSphere.SetActive(false);

                    _waterSpheres.SetActive(false);
                    
                }
            else if (_element == EElement.WATER)
            {
                    _element = EElement.NONE;
                    _waterSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(false);

                    _waterSpheres.SetActive(false);
                    

                    // do whatever you want to do when THUNDER touch WATER surface
                    _enemy2.Stun();
                    _enemy1.Stun();
                }
            else if (_element == EElement.NONE)
            {
                _element = EElement.THUNDER;
                    _waterSphere.SetActive(false);
                    _thunderSpheres.SetActive(false);
                    _thunderSphere.SetActive(true);

                    _waterSpheres.SetActive(false);

                }
            break;
        case EElement.FIRE:
            if (_element == EElement.FIRE)
            {
                    // do whatever you want to do when FIRE touch FIRE surface
                    // mini explosion bonus apparence
                    _element = EElement.FIRE;
                }
            else if (_element == EElement.THUNDER)
            {
                    // do whatever you want to do when FIRE touch THUNDER surface
                    _element = EElement.FIRE;
                }
            else if (_element == EElement.WATER)
            {
                    // do whatever you want to do when FIRE touch WATER surface
                    _element = EElement.FIRE;
                }
            else if (_element == EElement.NONE)
            {
                    _element = EElement.FIRE;
                }
            break;
    }
}


private void OnTriggerEnter(Collider collider)
{

    // Check if other is AElement
    AElement other = collider.GetComponent<AElement>();
    if (other != null )
    {
            if (other is ElementalProjectile)
            {
                ElementalProjectile elemProj = other.GetComponent<ElementalProjectile>();
                if (elemProj.InstanceID != gameObject.GetInstanceID())
                {
                    // React with other's element
                    ElementalReaction(other.Element);
                    Destroy(elemProj.gameObject);
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
